class AddResettingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :resetting, :boolean
  end
end
