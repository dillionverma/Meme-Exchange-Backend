class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  def jwt_token
    return unless Rails.env.development? || Rails.env.test?
    JWT.encode({ user_token: id }, Rails.application.secrets.secret_key_base, 'HS256', {})
  end

end
