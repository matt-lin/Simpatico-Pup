class AddBreedToSelectedComments < ActiveRecord::Migration
  def change
    add_column :selected_comments, :breed, :string
  end
end
