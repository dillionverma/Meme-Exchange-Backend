class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :coins, :bigint, default: 1000
    add_column :users, :username, :string
  end
end
