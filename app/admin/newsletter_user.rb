ActiveAdmin.register NewsletterUser do
  filter :email

  index do
    column :id
    column :email
    column :created_at
  end

end
