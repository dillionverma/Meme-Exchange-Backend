class AddActiveToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :active, :boolean, default: true
    User.update_all(active: true)
  end
end
