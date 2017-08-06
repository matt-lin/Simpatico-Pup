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
            line_chart User.group_by_day(:created_at).count, library: {animation: { easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "User", animation: "true"
          end
          column do
            line_chart Pup.group_by_day(:created_at).count, library: {animation: { easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Pup Creation", animation: "true"
          end
          column do
            line_chart Breeder.group_by_day(:id).count, library: {animation: { easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Breeder Creation", animation: "true"
          end
          column do
            line_chart NewsletterUser.group_by_day(:id).count, library: {animation: { easing: 'easeOutQuad' }},
            width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Breeder Creation", animation: "true"
          end
          column do
            geo_chart Breeder.group(:state).count,  library: {region: 'US', resolution: 'provinces'},
            width: "500px", height: "300px", animation: "true", title: "Concentration"
          end
          column do
            pie_chart (
              {
              "Leftmost button hit rate" => Impression.where(controller_name: "pups").where(action_name: "create").where(created_at: Time.current.all_week).length,
              "Left mid button hit rate" => Impression.where(controller_name: "pups").where(action_name: "breed").where(created_at: Time.current.all_week).length,
              "Right mid button hit rate" => Impression.where(controller_name: "pups").where(action_name: "dog_breeder").where(created_at: Time.current.all_week).length,
              "Rightmost button hit rate" => Impression.where(controller_name: "breeders").where(action_name: "nearer_breeders").where(created_at: Time.current.all_week).length
              }), width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Request distribution", animation: "true"
          end
           #{Impression.where(controller_name: "pups").where(action_name: "create").length}
        end
      end
      end
    end
  end
end
