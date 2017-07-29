#Iter 3-1 add column to sotre file catagory (By Gung Hiu Ho, Licong Wang)
class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :customizes, :welcome1, :name
    rename_column :customizes, :welcome2, :content
  end
end
