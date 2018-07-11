# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  transaction_type :string
#  price            :integer
#  quantity         :integer          default(0)
#  user_id          :integer
#  meme_id          :integer
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
