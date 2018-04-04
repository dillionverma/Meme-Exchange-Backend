class Api::V1::User::RegistrationsController < Api::V1::User::AuthenticatedController
  before_action :authenticate, except: :signup

  # {
  #   email:    'email@email.com',
  #   password: 'pass',
  #   token:    '343523raef'
  # }
  #
  # POST /api/v1/user/signup
  def signup
    user = ::User.new(user_params)
    if user.valid?
      user.save!
      render status: :ok,
        json: { token: encoded_token(user_token: user.id) }
    else
      render_validation_errors(user)
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
