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

FactoryBot.define do
  factory :transaction do
    user_id nil
    meme_id nil
    transaction_type "MyString"
    buy_date "2018-07-11 12:07:32"
    buy_price ""
    buy_quantity ""
    sell_date "2018-07-11 12:07:32"
    sell_price ""
    sell_quantity ""
  end
end
