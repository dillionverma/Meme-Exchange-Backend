class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.bigint :price
      t.bigint :quantity, default: 0
      t.references :user, foreign_key: true
      t.references :meme, foreign_key: true

      t.timestamps
    end
  end
end
