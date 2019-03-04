class CreateMemePortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :meme_portfolios do |t|
      t.references :user, foreign_key: true
      t.references :meme, foreign_key: true
      t.bigint :cost, default: 0
      t.bigint :quantity, default: 0

      t.timestamps
    end
  end
end
