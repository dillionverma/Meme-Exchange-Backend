class Api::V1::User::AuthenticatedController < Api::BaseController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  attr_reader :current_user

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      decoded_payload = decoded_token(token)[0]
      set_current_owner(decoded_payload['user_token'])
    end
  rescue ActiveRecord::RecordNotFound, JWT::VerificationError, JWT::DecodeError
    render_error(
      status: :unauthorized,
      code: '401',
      title: 'Login or signup to continue',
      detail: 'Authorization token invalid'
    )
  end

  def set_current_user(token)
    @current_user = User.findt(token)
  end
end
