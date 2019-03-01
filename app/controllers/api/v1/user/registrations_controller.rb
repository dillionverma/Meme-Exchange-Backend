class Api::V1::User::RegistrationsController < Api::V1::AuthenticatedController
  before_action :authenticate, except: :signup

  # {
  #   username: 'username',
  #   email:    'email@email.com',
  #   password: 'pass',
  # }
  #
  # POST /api/v1/user/signup
  def signup
    user = ::User.new(user_params)
    if user.valid?
      user.save!
      render status: :ok,
        json: { token: encoded_token(user_id: user.id), user: user }
    else
      render_validation_errors(user)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :username)
  end
end
