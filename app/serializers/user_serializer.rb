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
    # TODO: FIX ASAP
    # https://stackoverflow.com/questions/9796078/selecting-rows-ordered-by-some-column-and-distinct-on-another
    # https://dev.mysql.com/doc/refman/5.6/en/example-maximum-column-group-row.html
    @portfolio ||= self.object.meme_portfolios.joins("
        LEFT JOIN memes ON memes.id = meme_portfolios.meme_id 
        LEFT JOIN ( 
          SELECT mh1.id, mh1.meme_id, mh1.created_at, mh1.price 
          FROM meme_histories mh1
              JOIN (
                  SELECT meme_id, max(created_at) max_created_at
                  FROM meme_histories
                  GROUP BY meme_id
              ) mh2
          ON mh1.meme_id = mh2.meme_id AND mh1.created_at = mh2.max_created_at
          ORDER BY mh1.created_at DESC
        ) AS mh ON mh.meme_id = memes.id")
      .select("
        meme_portfolios.id, 
        memes.reddit_id, 
        memes.title, 
        memes.subreddit, 
        memes.author, 
        meme_portfolios.quantity, 
        mh.price as price, 
        price*meme_portfolios.quantity - meme_portfolios.cost as profit, 
        memes.url")
      .order(created_at: :desc)

  end

  def portfolio
    @portfolio.where("meme_portfolios.quantity != 0")
  end

  def portfolio_history
    @portfolio.where("meme_portfolios.quantity = 0") 
  end

end
