# == Schema Information
#
# Table name: transactions
#
#  id               :bigint(8)        not null, primary key
#  transaction_type :string
#  price            :bigint(8)        default(0)
#  quantity         :bigint(8)        default(0)
#  user_id          :bigint(8)
#  meme_id          :bigint(8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
