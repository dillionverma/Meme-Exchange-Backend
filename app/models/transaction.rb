class Transaction < ApplicationRecord
  belongs_to :user_id
  belongs_to :meme_id
end
