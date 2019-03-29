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

class UserSerializer < ActiveModel::Serializer
  attribute :id
  attribute :email
  attribute :username
  attribute :coins
  attribute :avatar
  has_many :portfolio
  has_many :portfolio_history
  

  def initialize(*args)
    super
    @portfolio ||= self.object.meme_portfolios.joins(meme: :meme_histories).order(created_at: :desc).select("meme_portfolios.id, memes.reddit_id, memes.title, memes.subreddit, memes.author, meme_portfolios.quantity, meme_histories.price as price, meme_histories.price - meme_portfolios.cost as profit, memes.url")
  end

  def portfolio
    @portfolio.where("meme_portfolios.quantity != 0")
  end

  def portfolio_history
    @portfolio.where("meme_portfolios.quantity = 0") 
  end

end
