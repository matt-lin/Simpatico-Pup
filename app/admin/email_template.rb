ActiveAdmin.register EmailTemplate do
  permit_params :title, :body
  batch_action :send do |id|
    if id.length == 1
      EmailTemplate.all.each do |b|
        b.marked = false
        b.save
      end
      
      batch_action_collection.find(id).each do |b|
        b.marked = true
        b.save
      end
      redirect_to admin_newsletter_users_path
    else
      redirect_to collection_path, notice: "A email can only includ one Email Template"
    end
  end
  
  filter :title
  filter :body
  filter :created_at
  filter :updated_at
  
  index do
    selectable_column
    column :title
    column :body
    actions
  end
  
  sidebar :"How to use" do
    h6 "Batch Actions"
    ul do
      li "Send Selected: Mark the selected email template and redirect to Newsletter Subscribers page to send out email template"
      li "Delete Selected: Permanently remove the marked the template from the site"
    end
  end
  
  form do |f|
    f.inputs "New Email Template" do
      f.input :title
      f.input :body
    end
    f.actions
  end
  
end
