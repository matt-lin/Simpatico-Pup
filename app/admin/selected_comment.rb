ActiveAdmin.register SelectedComment do
  filter :content
  filter :created_at
  index do
    selectable_column
    column :content
    column :user
    column :breeder do |c|
      link_to c.name
    end
    actions
  end
end