class AddLocationToCustomizes < ActiveRecord::Migration
  def change
    add_column :customizes, :location, :string, default: "Others"
  end
end
