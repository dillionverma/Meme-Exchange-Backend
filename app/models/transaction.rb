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

class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :meme

  validates :transaction_type, inclusion: { in: %w(buy sell), message: '%{value} is not a valid transaction type'},
                               allow_nil: false
  validates :price,            presence: true,
                               numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates :quantity,         numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validate  :can_buy?,         if: :buy?
  validate  :can_sell?,        if: :sell?

  after_create :update_user_coins
  after_create :update_meme_quantity
  after_create :update_meme_portfolio

  # At this point after validation, we are guaranteed we can update
  # balance without edge cases
  
  def update_user_coins
    user.update!(coins: user.coins - quantity * price) if buy?
    user.update!(coins: user.coins + quantity * price) if sell?
  end

  def update_meme_quantity
    meme.update!(quantity: meme.quantity + quantity) if buy?
    meme.update!(quantity: meme.quantity - quantity) if sell?
  end

  def update_meme_portfolio
    meme_portfolio = MemePortfolio.find_by(user: user, meme: meme)
    meme_portfolio.update!(quantity: meme_portfolio.quantity + quantity, cost: meme_portfolio.cost + quantity * price) if buy?
    meme_portfolio.update!(quantity: meme_portfolio.quantity - quantity, cost: meme_portfolio.cost - quantity * price) if sell?
  end

  def buy?
    transaction_type == 'buy'
  end

  def sell?
    transaction_type == 'sell'
  end

  def can_buy?
    errors.add('user', 'does not have enough coins to buy') if buy? && quantity*price > user.coins
  end

  def can_sell?
    errors.add('user', 'does not have enough quantity to sell') if sell? && quantity > meme.quantity
  end
end
