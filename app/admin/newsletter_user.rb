ActiveAdmin.register NewsletterUser do
  filter :email
  menu :label => 'Newsletter Subscribers'
  
  actions :all, except: [:update, :show, :edit, :new]
  
  index do
    selectable_column
    
    column :id
    column :email
    column :created_at
    actions
  end

end
