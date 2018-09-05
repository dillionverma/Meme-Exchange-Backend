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

class TransactionSerializer < ActiveModel::Serializer
  attribute :id
  attribute :transaction_type
  attribute :quantity
  attribute :price
  has_one :user
  has_one :meme
  attribute :created_at
  attribute :updated_at
end
