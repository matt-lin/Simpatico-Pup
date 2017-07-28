ActiveAdmin.register User do
  filter :username
  filter :created_at
  filter :last_sign_in_at

  index do
    column :id
    column :user_name do |u|
      link_to u.username, admin_user_path(u)
    end
    column :email
    column :created_at
  end

  show do
    attributes_table do
      row :id
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_at
      row :last_sign_in_ip
      row :created_at
      row :updated_at
      row :agreement
      row :activated
      panel "Dogs" do
        table_for user.pups do
          column :dog_name do |p|
            link_to p.pup_name, admin_dog_path(p)
          end
          column :comment do |p|
            p.comment.content
          end
          column :breeder_responsibility
          column :overall_health
          column :trainability
          column :social_behavior
          column :dog_behavior
          column :energy_level
          column :simpatico_rating
          column :hashtag_1
          column :hashtag_2
          column :hashtag_3
          column :created_at
        end
      end
    end
  end
end
