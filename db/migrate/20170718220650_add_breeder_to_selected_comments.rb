#Iter 2-2 Added column to fix Dog page bugs (By Gung Hiu Ho, Licong Wang)
class AddBreederToSelectedComments < ActiveRecord::Migration
  def change
    add_column :selected_comments, :breeder, :string
  end
end
