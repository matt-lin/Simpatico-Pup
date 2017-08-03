ActiveAdmin.register Breed do
  filter :name
  actions :all, except: [:show]
  index do
    column :id
    column :name do |b|
      link_to b.name, admin_breed_path(b)
    end
    actions
  end
end
