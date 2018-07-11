class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :coins, :bigint
    add_column :users, :username, :string
  end
end