ActiveAdmin.register Breed do
  
  menu :priority => 3
  
  filter :name
  actions :all, except: [:show]
  index do
    selectable_column
    column :id
    column :name do |b|
      link_to b.name, admin_breed_path(b)
    end
    actions
  end
end
