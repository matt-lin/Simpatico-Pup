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
end
