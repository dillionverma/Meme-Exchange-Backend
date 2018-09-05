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

FactoryBot.define do
  factory :meme do
    subreddit "MyString"
    title "MyString"
    author "MyString"
    quantity ""
    reddit_id "MyString"
    url "MyText"
  end
end
