ActiveAdmin.register EmailTemplate do
  permit_params :title, :body
  batch_action :send do |ids|
    redirect_to admin_newsletter_users_path
  end
  batch_action :mark do |ids|
    batch_action_collection.find(ids).each do |b|
      b.marked = true
      b.save
    end
    redirect_to collection_path, notice: "The selected template have been marked and will be the email."
  end
  
  batch_action :unmark do |ids|
    batch_action_collection.find(ids).each do |a|
      b.marked = false
      b.save
    end
    redirect_to collection_path, notice: "The selected template have been unmarked and will not be the email."
  end
end
