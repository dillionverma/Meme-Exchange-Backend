# == Schema Information
#
# Table name: third_party_identities
#
#  id               :bigint(8)        not null, primary key
#  user_id          :bigint(8)
#  provider_name    :string
#  provider_side_id :string
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :third_party_identity do
    user nil
    provider_name "MyString"
    provider_side_id "MyString"
    status "MyString"
  end
end
