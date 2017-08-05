# Iter 1-2 (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Comment, as: "User Comments" do
  
  menu :priority => 5
  
  batch_action :approve do |ids|
    batch_action_collection.find(ids).each do |c|
      @SelectedComment = SelectedComment.new({:content => c.content})
      @SelectedComment.user = c.pup.user.username if !c.pup.user.nil?
      @SelectedComment.breed = c.pup.breed.name
      @SelectedComment.breeder = c.pup.breeder.name if !c.pup.breeder.nil?
      @SelectedComment.save
    end
    redirect_to collection_path, alert: "The chosen comments have been approved."
  end
  
  actions :all, except: [:update, :show, :edit, :new]
  # filter :pup
  filter :content
  filter :created_at
  
  #Iter 2-2 Redesigned selected comment column (By Gung Hiu Ho, Licong Wang)
  index do
    selectable_column
    
    column :dog_name do |c|
      c.pup.pup_name
    end
    column :user_name do |c|
      auto_link c.pup.user
    end
    column :breed do |c|
      !c.pup.breed.nil? ? c.pup.breed.name : ""
    end
    column :content
    column :created_at
    actions
  end
end

# End for Iter 1-2