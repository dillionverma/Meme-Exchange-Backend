# == Schema Information
#
# Table name: memes
#
#  id         :integer          not null, primary key
#  title      :string
#  subreddit  :string
#  author     :string
#  url        :text
#  price      :integer
#  quantity   :integer          default(0)
#  reddit_id  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meme < ApplicationRecord
  has_many :transactions
  #has_many :meme_histories
  #has_many :meme_portfolios
  has_many :users, through: :transactions

  #validates :title,     presence: true
  #validates :url,       presence: true
  #validates :subreddit, presence: true
  #validates :reddit_id, presence: true
  #validates :quantity,  presence: true, numericality: { greater_than_or_equal_to: 0 }


  scope :active, -> { where("quantity!='0'") }

end
