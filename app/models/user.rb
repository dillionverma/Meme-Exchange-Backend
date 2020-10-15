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
  has_many :meme_portfolios

  before_validation :generate_username

  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9\-_]+\z/
  validates :username, presence: { message: 'username must be given' },
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 20 },
                       format: { with: VALID_USERNAME_REGEX, message: 'must contain only letters, numbers, underscores or dashes' }

  def self.leaderboard
    # TODO: MOVE THIS TO A REDIS IN-MEMORY IMPLEMENTATION - USE SORTED-SETS (ZSETS)
    # https://redislabs.com/solutions/use-cases/leaderboards/
    # https://www.ionos.com/community/hosting/redis/how-to-implement-a-simple-redis-leaderboard/
    User.select(:id, :avatar, :username, :coins).order(coins: :desc).where(active: true)
  end

  def generate_username
    self.username = "user#{((User.last&.id || 0) + 1)}" if self.username.nil?
  end

  def jwt_token
    return unless Rails.env.development? || Rails.env.test?
    JWT.encode({ user_id: id }, Rails.application.secrets.secret_key_base, 'HS256', {})
  end
  
  # DANGER ZONE
  def reset
    ActiveRecord::Base.transaction do
      self.meme_portfolios.each do |portfolio|

        # Subtract quantity from global meme supply
        portfolio.meme.update(quantity: portfolio.meme.quantity - portfolio.quantity)

        # Delete the record
        portfolio.destroy
      end

      # Delete all transactions
      self.transactions.destroy_all

      # Reset coins
      update!(coins: 1000)
    end

  end

end
