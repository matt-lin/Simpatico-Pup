ActiveAdmin.register SelectedComment do
  filter :content
  filter :created_at
  index do
    column :content
    column :user
    actions
  end
end