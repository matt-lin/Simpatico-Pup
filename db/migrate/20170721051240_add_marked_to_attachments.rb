#Iter 2-2 Added column for attachment (By Gung Hiu Ho, Licong Wang)
class AddMarkedToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :marked, :boolean, default: false
  end
end
