# Iter 1-2
ActiveAdmin.register Comment, as: "User Comments" do
  batch_action :approve do |ids|
    batch_action_collection.find(ids).each do |c|
      @SelectedComment = SelectedComment.new({:content => c.content, :user => c.pup.user.username, :breed => c.pup.breed.name})
      #@SelectedComment.breed =  c.pup.breed.name
      @SelectedComment.breeder =  c.pup.breeder.name
      puts "breed: name #{c.pup.breed.name}, Actual: #{@SelectedComment.breed}"
      puts "breeder: name #{c.pup.breeder.name}, Actual: #{@SelectedComment.breeder}"
      puts @SelectedComment.breeder
      @SelectedComment.save
    end
    redirect_to collection_path, alert: "The posts have been flagged."
  end
  
  actions :all, except: [:update, :show, :edit, :new]
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
    column :breed do |c|
      link_to c.pup.breed.name
    end
    column :content
    column :created_at
    actions
  end
end

# End for Iter 1-2
