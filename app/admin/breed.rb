ActiveAdmin.register Breed do
  
  menu :priority => 3
  
  filter :name
  actions :all, except: [:show]
  index do
    selectable_column
    column :id
    column :name
    actions
  end
end
