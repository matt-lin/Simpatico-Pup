class AddOwnerNameToPups < ActiveRecord::Migration
  def change
    add_column :pups, :owner_name, :string
  end
end
