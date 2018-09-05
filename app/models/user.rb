# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  coins                  :bigint(8)        default(1000)
#  username               :string
#  avatar                 :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :transactions
  has_many :memes, through: :transactions
  has_many :third_party_identities

  #VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
  #validates :username, presence: { message: 'username must be given please' },
                       #uniqueness: { case_sensitive: false },
                       #length: { minimum: 3, maximum: 20 },
                       #format: { without: VALID_USERNAME_REGEX, message: 'must contain only letters or numbers' }

  def jwt_token
    return unless Rails.env.development? || Rails.env.test?
    JWT.encode({ user_id: id }, Rails.application.secrets.secret_key_base, 'HS256', {})
  end

end
