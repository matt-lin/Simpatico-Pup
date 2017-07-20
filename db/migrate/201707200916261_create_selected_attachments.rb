class CreateSelectedAttachments < ActiveRecord::Migration
  def change
    create_table :selected_attachments do |t|
      t.string :filename
    end
  end
end
