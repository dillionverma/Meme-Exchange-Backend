class Api::V1::User::SessionsController < Api::V1::AuthenticatedController
  before_action :authenticate, except: [:login, :third_party_login]
  before_action :set_login_params, only: [:login]
  before_action :set_third_party_login_params, only: [:third_party_login]

  # {
  #   email:    'email@email.com',
  #   password: 'pass',
  # }
  #
  # POST /api/v1/user/login
  def login
    user = ::User.find_by(email: @email)
    if user.nil?
      render_error(
        status: :unauthorized,
        code: '401',
        title: "User with email #{@email} not found.",
        detail: 'email'
      )
    elsif user.valid_password?(@password)
      render status: :ok,
             json: { token: encoded_token(user_id: user.id) }
    else
      render_error(
        status: :unauthorized,
        code: '401',
        title: 'Invalid password',
        detail: 'password'
      )
    end
  end

  # {
  #   provider_name:    'facebook',
  #   provider_side_id: 'asvkna3280fasldv',
  #   auth_token:       '12090fna0w9ecl3hadf',
  #   auth_expires_at:  '1029410813'
  # }
  #
  # POST /api/v1/user/third-party-login
  def third_party_login
    if @provider_name == "facebook"
      create_account_from_facebook
    elsif @provider_name == "google"
      create_account_from_google
    else
      raise VerificationError, "Unknown provider #{@provider_name}"
    end

  end

  # DELETE /api/v1/user/logout
  def logout
    render status: :ok, json: {}
  end

  private

  def set_login_params
    @email = params.fetch(:email)
    @password = params.fetch(:password)
  end

  def set_third_party_login_params
    @provider_name = params.fetch(:provider_name)
    @provider_side_id = params.fetch(:provider_side_id)
    @auth_token = params.fetch(:auth_token)
    @auth_expires_at = params.fetch(:auth_expires_at)
  end


  def create_account_from_google
    begin
      url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{@auth_token}"                  
      info = HTTParty.get(url)&.deep_symbolize_keys
    rescue => e
      Rails.logger.info(e.message)
      raise VerificationError, "Could not verify auth token, error: #{e.message}"
    end
    unless info[:email].present?
      raise VerificationError, "Could not access email on #{@provider_name.humanize}"
    end
    create_or_update_user(email: info[:email], avatar: info[:picture])
  end


  def create_account_from_facebook
    fb_identity = Koala::Facebook::API.new(@auth_token)
    begin
      info = fb_identity.get_object('me', fields: 'email,name,verified,picture.type(large)')&.deep_symbolize_keys
    rescue Koala::Facebook::AuthenticationError, Koala::Facebook::ServerError => e
      Rails.logger.info(e.message)
      raise VerificationError, "Could not verify auth token, error: #{e.message}"
    end
    unless info[:email].present?
      raise VerificationError, "Could not access email on #{@provider_name.humanize}"
    end
    create_or_update_user(email: info[:email], avatar: info[:picture][:data][:url])
  end

  def create_or_update_user(email:, avatar:)
    existing_identity = ThirdPartyIdentity.includes(:user).find_by(
      provider_name:    @provider_name,
      provider_side_id: @provider_side_id
    )

    ThirdPartyIdentity.transaction do
      if existing_identity.present?
        # existing_identity.user.update!(email: email, avatar: avatar)
        render json: { token: encoded_token(user_id: existing_identity.user.id), user: existing_identity.user }
      else
        user = ::User.find_by(email: email)
        new_identity = ThirdPartyIdentity.new(
          provider_name:    @provider_name,
          provider_side_id: @provider_side_id
        )
        if user.blank?
          user = ::User.create!(
            email:    email,
            password: SecureRandom.hex(8),
            avatar:   avatar
          )
        end
        new_identity.update!(user_id: user.id)
        new_identity.save!
        render json: { token: encoded_token(user_id: new_identity.user.id), user: user }
      end
    end
    rescue VerificationError
      render_error(
        status: :internal_server_error,
        code: '500',
        title: 'Verification Error',
        detail: "#{@provider_name.humanize} verification failed"
      )
    end
end
