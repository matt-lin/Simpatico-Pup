ActiveAdmin.register NewsletterUser do
  filter :email
  menu :label => 'Newsletter Subscribers'

  index do
    column :id
    column :email
    column :created_at
  end

end
