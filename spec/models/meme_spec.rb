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

require 'rails_helper'

RSpec.describe Meme, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
