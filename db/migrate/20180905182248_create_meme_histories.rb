class CreateMemeHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :meme_histories do |t|
      t.references :meme, foreign_key: true
      t.string :reddit_id
      t.bigint :price
      t.datetime :date

      t.timestamps
    end
  end
end
