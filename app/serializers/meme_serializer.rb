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

class MemeSerializer < ActiveModel::Serializer
  #attribute :id
  attribute :title
  attribute :subreddit
  attribute :author
  attribute :url
  attribute :price
  attribute :quantity
  attribute :reddit_id
  attribute :created_at
  attribute :updated_at
end
