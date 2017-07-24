#Iter 2-2 Added breed column to fix existing bug in dog page (By Gung Hiu Ho, Licong Wang)
class AddBreedToSelectedComments < ActiveRecord::Migration
  def change
    add_column :selected_comments, :breed, :string
  end
end
