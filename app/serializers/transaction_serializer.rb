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
