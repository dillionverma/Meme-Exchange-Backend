class MemePortfolio < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :meme, touch: true

  validates_associated :user
  validates_associated :meme

  validates :quantity,   presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cost,      presence: true

end
