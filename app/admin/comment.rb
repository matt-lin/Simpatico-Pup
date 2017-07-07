ActiveAdmin.register Comment, as: "User Comments" do
  actions :all, except: [:update, :edit, :show]
  # filter :pup
  filter :content
  filter :created_at
  index do
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
