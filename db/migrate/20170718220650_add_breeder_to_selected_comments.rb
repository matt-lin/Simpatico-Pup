class AddBreederToSelectedComments < ActiveRecord::Migration
  def change
    add_column :selected_comments, :breeder, :string
  end
end
