# Iter 1-2
ActiveAdmin.register SelectedComment do
  filter :content
  filter :created_at
  index do
    selectable_column
    column :content
    column :breed do |s|
      s.breed
    end
    column :breeder
    column :user
    actions
  end
end
# End for Iter 1-2