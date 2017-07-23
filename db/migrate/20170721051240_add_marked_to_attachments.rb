class AddMarkedToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :marked, :boolean, default: false
  end
end
