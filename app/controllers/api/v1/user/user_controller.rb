class Api::V1::User::UserController < Api::V1::AuthenticatedController
  def show
    respond_with current_user
  end
end
