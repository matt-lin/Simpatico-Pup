#Iter 3-2 Added table for customize (By Gung Hiu Ho, Licong Wang)
class CreateCustomizes < ActiveRecord::Migration
  def change
    create_table :customizes do |t|
      t.string :welcome1
      t.string :welcome2
    end
  end
  
  def self.up
    rename_column :customizes, :welcome1, :name
    rename_column :customizes, :welcome2, :content
  end
end