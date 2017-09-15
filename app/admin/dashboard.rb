#Iter 2-2 Disable the link for "pup_name" and fixed routing bug (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }
  
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Today's Dogs" do
          table_for Pup.where(created_at: Date.today..Date.today.next) do
            column :dog_name do |p|
              p.pup_name
            end
            column :dog_breed do |p|
              p.breed.name
            end
            column :dog_breeder do |p|
              !p.breeder.nil? ? p.breeder.name : "unknown"
            end
            column :dog_owner do |p|
              p.user.username if !p.user.nil?
            end
            column :created_at
          end
        end
        panel "Today's User" do
          table_for User.where(created_at: Date.today..Date.today.next) do
            column :user_name do |u|
              u.username
            end
            column :email do |u|
              u.email
            end
          end
        end
      end
    end
  end
end
