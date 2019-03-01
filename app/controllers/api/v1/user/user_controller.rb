class Api::V1::User::UserController < Api::V1::AuthenticatedController
 before_action :authenticate, only: [:me]

  def show
    user = ::User.find_by(username: params[:username])
    if user.nil?
      render_error(
        status: :not_found,
        code: '404',
        title: 'Resource not found',
        detail: "User with username #{params[:username]} not found"
      )
    else 
      respond_with user
    end
  end

  def me
    respond_with current_user
  end

  def transactions
    user = ::User.find_by(username: params[:username])
    if user.nil?
      render_error(
        status: :not_found,
        code: '404',
        title: 'Resource not found',
        detail: "User with username #{params[:username]} not found"
      )
    else 
      respond_with user.transactions.includes(:meme).order(created_at: :desc)
    end
  end

end

