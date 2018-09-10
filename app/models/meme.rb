# == Schema Information
#
# Table name: memes
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  subreddit  :string
#  author     :string
#  url        :text
#  quantity   :bigint(8)        default(0)
#  reddit_id  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meme < ApplicationRecord
  has_many :transactions
  has_many :meme_histories
  has_many :users, through: :transactions

  #validates :title,     presence: true
  #validates :url,       presence: true
  #validates :subreddit, presence: true
  #validates :reddit_id, presence: true
  #validates :quantity,  presence: true, numericality: { greater_than_or_equal_to: 0 }


  scope :active, -> { where("memes.quantity!='0'") }


  def self.from_reddit(reddit_id)
    search_id = reddit_id
    search_id = "t3_#{reddit_id}" if !reddit_id.starts_with?('t3')

    Meme.transaction do 
      meme = Meme.new
      m = Reddit.from_ids(search_id).to_ary[0]
      meme.update!(title:     m.title,
                   author:    m.author.name,
                   reddit_id: reddit_id,
                   subreddit: m.subreddit.title,
                   url:       m.url,
                   permalink: m.permalink)
      MemeHistory.create!(reddit_id: reddit_id,
                          price: m.score, 
                          meme: meme, 
                          date: Time.now)
      meme
    end
  end

  def price
    meme_histories.last.price
  end

end
