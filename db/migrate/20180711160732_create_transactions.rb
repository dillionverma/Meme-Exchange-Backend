class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.datetime :buy_date
      t.bigint :buy_price
      t.bigint :buy_quantity, default: 0
      t.datetime :sell_date
      t.bigint :sell_price
      t.bigint :sell_quantity, default: 0
      t.references :user, foreign_key: true
      t.references :meme, foreign_key: true

      t.timestamps
    end
  end
end
