class Api::V1::User::SessionsController < Api::V1::User::AuthenticatedController
  before_action :authenticate, except: :login
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

  # DELETE /api/v1/user/logout
  def logout
    render status: :ok, json: {}
  end

  private

  def set_login_params
    @email = params.fetch(:email)
    @password = params.fetch(:password)
  end
end
