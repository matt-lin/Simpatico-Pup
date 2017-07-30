class AddMarkedToEmailTemplates < ActiveRecord::Migration
  def change
    add_column :email_templates, :marked, :boolean, default: false
  end
end
