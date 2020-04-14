class Api::V1::AuthenticatedController < Api::BaseController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  attr_reader :current_user

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      decoded_payload = decoded_token(token)[0]
      set_current_user(decoded_payload['user_id'])
    end
  rescue ActiveRecord::RecordNotFound, JWT::VerificationError, JWT::DecodeError
    render_error(
      status: :unauthorized,
      code: '401',
      title: 'Authorization token invalid',
      detail: 'Login or signup to continue'
    )
  end

  def set_current_user(id)
    user = ::User.find(id)
    if user.active
      @current_user = user
    else
      render_error(
        status: :not_found,
        code: '404',
        title: 'User not found',
        detail: 'Login or signup to continue'
      )
    end
  end
end
