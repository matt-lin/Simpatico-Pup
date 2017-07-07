ActiveAdmin.register Comment, as: "User Comments" do
  actions :all, except: [:update, :destroy]
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

    column "" do |resource|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
    
  end
end
