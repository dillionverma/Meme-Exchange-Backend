class CreateMemes < ActiveRecord::Migration[5.1]
  def change
    create_table :memes do |t|
      t.string :title
      t.string :subreddit
      t.string :author
      t.text :url
      t.bigint :price
      t.bigint :quantity, default: 0
      t.string :reddit_id

      t.timestamps
    end
  end
end
