class Api::V1::User::UserController < Api::V1::AuthenticatedController
 before_action :authenticate, only: [:me, :update_username, :reset_user]

  # GET /api/v1/user
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

  # {
  #   username:    'memelord',
  # }
  #
  # PUT /api/v1/user/username
  def update_username
    current_user.update!(username: params[:username])
    render status: :ok, json: { user: current_user }
  end

  # POST /api/v1/user/reset
  def reset_user
    current_user.reset
    render status: :ok, json: { user: current_user }
  end

  # {
  #   current_password:    'oldpass',
  #   new_password:        'mynewpass'
  # }
  #
  # def change_password
  #   if current_user.valid_password?(params[:current_password])
  #     respond_with current_user.update!(password: [:new_password])
  #   else
  #     render_error(
  #       status: :unauthorized,
  #       code: '401',
  #       title: 'Invalid password',
  #       detail: 'Current password incorrect'
  #     )
  #   end
  # end

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

