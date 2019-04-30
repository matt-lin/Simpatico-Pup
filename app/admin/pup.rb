#Iter 2-2 Redesign dog page (By Gung Hiu Ho, Licong Wang)
def destroy_and_increment_removed(id)
  dog = Pup.find(id)
  breeder = Breeder.find(dog.breeder_id)
  if dog.destroy
    old_value = breeder.removed_reviews
    breeder.removed_reviews = old_value + 1
    breeder.save
  end
end
ActiveAdmin.register Pup, as: "Dogs" do
  
  menu :priority => 2
  
  filter :user
  filter :breeder
  filter :breed
  filter :pup_name
  actions :all, except: [:update, :new, :edit]
  
  batch_action :destroy, confirm: "Are you sure you want to delete these pups?" do |ids|
    ids.each do |i|
      destroy_and_increment_removed(i)
    end
    redirect_to admin_dogs_path
  end
  
index do
  
    selectable_column
    column :name do |p|
     link_to p.pup_name, admin_dog_path(p)
    end
    column :age do |p|
      p.year.to_s + " year(s) and " + p.month.to_s + " month(s)"
    end
    column :breed do |p|
      p.breed.name
    end
    column "Breeder" do |p|
      link_to p.breeder.name, admin_breeder_path(p.breeder)
    end
    column :user
    column :comment do |p|
      !p.comment.nil? ? p.comment.content : ""
    end
    column :created_at
    column :updated_at
    actions
end

  config.action_items.delete_if { |item|
    # item is an ActiveAdmin::ActionItem
    item.display_on?(:show)
  }

  action_item :only => :show do
    link_to "Delete Dog" , admin_dog_path, method: :delete, data: { confirm: 'Are you sure you want to delete ?'}
  end

  controller do

    def destroy
      destroy_and_increment_removed(params["id"])
      redirect_to admin_dogs_path
    end

  end


  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions
  end

end


