ActiveAdmin.register Feedback do

  menu :priority => 15

  # filter :name
  menu :label => 'Site Feedback'
  actions :all, except: [:show]
  index do
    selectable_column
    column :id
    column :rate_dog
    column :breed_rating
    column :breeder_rating
    column :search_breeder
    column :forum
    column :open_response
    actions
  end
end
