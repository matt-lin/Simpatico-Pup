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
          end
        end
        panel "Today's User" do
          table_for User.where(created_at: Date.today..Date.today.next) do
            column :user_name do |p|
              p.username
            end
          end
        end
        
      panel "Site Statistic" do
      columns do
          column do
            line_chart  User.group_by_day(:created_at).count, 
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "User", animation: "true"
          end
          column do
            line_chart  Pup.group_by_day(:created_at).count, 
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Pup Creation", animation: "true"
          end
          column do
            line_chart  Breeder.group_by_day(:id).count, 
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Breeder Creation", animation: "true"
          end
          column do
            geo_chart Breeder.group(:state).count,  library: {region: 'US', resolution: 'provinces'},
            width: "500px", height: "300px", animation: "true", title: "Concentration"
          end
        end
      end
      end
    end
  end
end
