class Api::BaseController < ApplicationController
  self.responder = Responders::ApiResponder
  include ErrorHandlerMixin, Errors
  respond_to :json

  protected

  def encoded_token(payload, header_fields = {})
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256', header_fields)
  end

  def decoded_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end
end
