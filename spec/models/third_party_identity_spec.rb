# == Schema Information
#
# Table name: third_party_identities
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  provider_name    :string
#  provider_side_id :string
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe ThirdPartyIdentity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
