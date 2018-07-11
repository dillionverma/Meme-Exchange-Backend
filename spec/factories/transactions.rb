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
