ActiveAdmin.register SelectedComment do
  filter :content
  filter :created_at
  index do
    selectable_column
    column :content
    column :user
    actions
  end
end