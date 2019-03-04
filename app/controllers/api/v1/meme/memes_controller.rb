class Api::V1::Meme::MemesController < Api::V1::AuthenticatedController

  # /api/v1/meme/:id
  def show
    respond_with meme
  end

  # {
  #   quantity: 4
  # }
  #
  # /api/v1/meme/:id/buy
  def buy
    respond_with create_buy_transaction(params.fetch(:quantity))
  end
  
  # {
  #   quantity: 4
  # }
  #
  # /api/v1/meme/:id/sell
  def sell
    respond_with create_sell_transaction(params.fetch(:quantity))
  end

  private

  def create_buy_transaction(quantity)
    MemePortfolio.find_or_create_by!(user: current_user, meme: meme)
    Transaction.create!(user: current_user, meme: meme, quantity: quantity, 
                        price: meme.price, transaction_type: 'buy')
  end

  def create_sell_transaction(quantity)
    Transaction.create!(user: current_user, meme: meme, quantity: quantity, 
                        price: meme.price, transaction_type: 'sell')
  end

  def meme
    @meme ||= ::Meme.find_by(reddit_id: params.fetch(:id)) || Meme.from_reddit(params.fetch(:id))
  end

end
