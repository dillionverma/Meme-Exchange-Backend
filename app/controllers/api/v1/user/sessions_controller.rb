class Api::V1::User::SessionsController < Api::V1::AuthenticatedController
  before_action :authenticate, except: [:login, :third_party_login]
  before_action :set_login_params, only: [:login]

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
    existing_identity = ThirdPartyIdentity.find_by(
      provider_name:    third_party_login_params.fetch(:provider_name),
      provider_side_id: third_party_login_params.fetch(:provider_side_id)
    )
    fb_identity = Koala::Facebook::API.new(third_party_login_params.fetch(:auth_token))
    begin
      info = fb_identity.get_object('me', fields: 'email,name,verified,picture.type(large)')&.deep_symbolize_keys
    rescue Koala::Facebook::AuthenticationError, Koala::Facebook::ServerError => e
      Rails.logger.info(e.message)
      raise VerificationError, "Could not verify auth token, error: #{e.message}"
    end

    fbid = info[:id]
    unless info[:email].present? && info[:name].present?
      raise VerificationError, "Could not get email or name for #{fbid}"
    end

    ThirdPartyIdentity.transaction do
      if existing_identity.present?
        existing_identity.user.update!(email: info[:email],
                                       avatar: info[:picture][:data][:url])
        render json: { token: encoded_token(user_id: existing_identity.user.id), user: existing_identity.user }
      else
        user = ::User.find_by(email: info[:email])
        new_identity = ThirdPartyIdentity.new(
          provider_name:    third_party_login_params.fetch(:provider_name),
          provider_side_id: third_party_login_params.fetch(:provider_side_id)
        )
        if user.blank?
          user = ::User.create!(
            email:    info[:email],
            password: SecureRandom.hex(8),
            avatar: info[:picture][:data][:url]
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
      detail: 'Facebook verification failed'
    )
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

  def third_party_login_params
    params.permit(:provider_name, :provider_side_id, :auth_token, :auth_expires_at)
  end
end
