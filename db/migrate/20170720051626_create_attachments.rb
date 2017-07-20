class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :document
      t.belongs_to :selected_attachment, index: true
    end
  end
end