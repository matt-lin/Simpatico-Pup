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
  
end
