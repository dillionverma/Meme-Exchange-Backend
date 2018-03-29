class Api::V1::User::RegistrationsController < Api::V1::User::AuthenticatedController
  before_action :authenticate, except: :sign_up
  # {
  #   email:    'email@email.com',
  #   password: 'pass',
  # }
  #
  # POST /api/v1/user/signup
  def sign_up
    user = User.new(user_params)
    if user.valid?
      user.save!
      render status: :ok,
             json: { token: encoded_token(user_token: user.token) }
    else
      render_validation_errors(owner)
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
