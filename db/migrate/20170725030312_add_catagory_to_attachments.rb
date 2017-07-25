#Iter 3-1 add column to sotre file catagory (By Gung Hiu Ho, Licong Wang)
class AddCatagoryToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :catagory, :string
  end
end
