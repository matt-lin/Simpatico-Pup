ActiveAdmin.register Comment, as: "User Comments" do
  batch_action :approve do |ids|
    batch_action_collection.find(ids).each do |c|
      @SelectedComment = SelectedComment.new({:content => c.content})
      @SelectedComment.user = c.pup.user.username
      @SelectedComment.save
    end
    redirect_to collection_path, alert: "The posts have been flagged."
  end
  
  
  actions :all, except: [:update, :show]
  # filter :pup
  filter :content
  filter :created_at
  index do
    selectable_column
    
    column :dog_name do |c|
      link_to c.pup.pup_name, admin_dog_path(c.pup)
    end
    column :user_name do |c|
      auto_link c.pup.user
    end
    column :content
    column :created_at
    actions
  end
end
