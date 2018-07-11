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

FactoryBot.define do
  factory :meme do
    subreddit "MyString"
    title "MyString"
    author "MyString"
    price ""
    quantity ""
    reddit_id "MyString"
    url "MyText"
  end
end
