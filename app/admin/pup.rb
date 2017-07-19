ActiveAdmin.register Pup, as: "Dogs" do
  filter :user
  filter :breeder
  filter :breed
  filter :pup_name
  actions :all, except: [:update, :show, :new]
index do
  
    selectable_column
    column :name do |p|
      p.pup_name
    end
    column :breed do |p|
      auto_link p.breed
    end
    column "Breeder" do |p|
      link_to p.breeder.name, admin_breeder_path(p.breeder)
    end
    column :user
    column :comment do |p|
      p.comment.content
    end
    column :created_at
    column :updated_at
    column :breeder_responsibility
    column :overall_health
    column :trainability
    column :social_behavior
    column :dog_behavior
    column :energy_level
    column :simpatico_rating
    actions
  end

  config.action_items.delete_if { |item|
    # item is an ActiveAdmin::ActionItem
    item.display_on?(:show)
  }

  action_item :only => :show do |dog|
    link_to "Edit Dog" , edit_admin_dog_path
  end

  action_item :only => :show do
    link_to "Delete Dog" , admin_dog_path, method: :delete, data: { confirm: 'Are you sure you want to delete ?'}
  end

  action_item only: :show do
    link_to 'Delete Dog At Breeder Request', admin_dog_path(type: :user), method: :delete, data: { confirm: 'Are you sure you want to delete ?'}
  end

  controller do

    def destroy
      dog = Pup.find(params["id"])
      breeder = Breeder.find(dog.breeder_id)
      if params[:type].present?
        if params[:type] == "user"
          if dog.destroy
            old_value = breeder.removed_reviews
            breeder.removed_reviews = old_value + 1
            breeder.save
          end
        end
      else
        dog.destroy
      end
      redirect_to admin_dogs_path
    end

  end


  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions
  end

end
