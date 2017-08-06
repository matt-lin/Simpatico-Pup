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
        
      panel "Site Statistic" do
      columns do
          column do
            line_chart User.group_by_day(:created_at).count, library: {animation: {duration: 1000, easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "User"
          end
          column do
            line_chart Pup.group_by_day(:created_at).count, library: {animation: {duration: 1050, easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Pup Creation", animation: "true"
          end
          column do
            line_chart Breeder.group_by_day(:id).count, library: {animation: {duration: 1100, easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Breeder Creation", animation: "true"
          end
          column do
            line_chart NewsletterUser.group_by_day(:id).count, library: {animation: {duration: 1150, easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Breeder Creation", animation: "true"
          end
          column do
            geo_chart Breeder.group(:state).count,  library: {region: 'US', resolution: 'provinces'},
            width: "500px", height: "300px", animation: "true", title: "Concentration"
          end
        end
        columns do
          column do
            pie_chart (
              {
              "Leftmost button hit rate" => Impression.where(controller_name: "pups").where(action_name: "create").where(created_at: Time.current.all_week).length,
              "Left mid button hit rate" => Impression.where(controller_name: "pups").where(action_name: "breed").where(created_at: Time.current.all_week).length,
              "Right mid button hit rate" => Impression.where(controller_name: "pups").where(action_name: "dog_breeder").where(created_at: Time.current.all_week).length,
              "Rightmost button hit rate" => Impression.where(controller_name: "breeders").where(action_name: "nearer_breeders").where(created_at: Time.current.all_week).length
              }),library: {animation: {duration: 500, easing: 'easeOutQuad' }}, donut: true, width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Request distribution", animation: "true"
          end
          column do
            area_chart (
              {
              0.day.ago => Impression.where(created_at: 0.day.ago.all_day).length,
              1.day.ago => Impression.where(created_at: 1.day.ago.all_day).length,
              2.day.ago => Impression.where(created_at: 2.day.ago.all_day).length,
              3.day.ago => Impression.where(created_at: 3.day.ago.all_day).length,
              4.day.ago => Impression.where(created_at: 4.day.ago.all_day).length,
              5.day.ago => Impression.where(created_at: 5.day.ago.all_day).length,
              6.day.ago => Impression.where(created_at: 6.day.ago.all_day).length,
              7.day.ago => Impression.where(created_at: 7.day.ago.all_day).length,
              }),  library: {animation: {duration: 1000, easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", 
            ytitle: "Population", title: "Request Handled", animation: "true"
            
          end
          column do
            text_node "Failed rate on leftmostpage: #{(Impression.where(controller_name: "pups").count - Impression.where(controller_name: "pups").where(action_name: "create").where(created_at: Time.current.all_week).length*6) / Impression.where(controller_name: "pups").count}%"
          end
        end
      end
      end
    end
  end
end
