ActiveAdmin.register Impression do
    menu :label => 'Site Analysis'
    config.batch_actions = false
    
    index do
        panel "User Statistics" do
            columns do
                column do
                    area_chart User.group_by_day(:created_at).count, library: {animation: {duration: 1000, easing: 'easeOutQuad' }},
                    width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "User"  
                end
                column do
                    area_chart NewsletterUser.group_by_day(:id).count, library: {animation: {duration: 1150, easing: 'easeOutQuad' }},
                    width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Subscriber Trending", animation: "true"
                end
            end
        end
        panel "Pup Statistics" do
            columns do
                column do
                    line_chart Pup.group_by_day(:created_at).count, library: {animation: {duration: 1050, easing: 'easeOutQuad' }},
                    width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Pup Creation", animation: "true"
                end
            end
        end
        panel "Breeder Statistics" do
            columns do
                column do
                    line_chart Breeder.group_by_day(:id).count, library: {animation: {duration: 1100, easing: 'easeOutQuad' }},
                    width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Breeder Creation", animation: "true"
                end
                column do
                    geo_chart Breeder.group(:state).count,  library: {region: 'US', resolution: 'provinces'},
                    width: "500px", height: "300px", animation: "true", title: "Concentration"
                end
            end
        end
        
        panel "Site preformance Statistic" do
            columns do
                column do
                    pie_chart ({ 
                    "Leftmost button hit rate" => Impression.where(controller_name: "pups").where(action_name: "create").where(created_at: Time.current.all_week).length,
                    "Left mid button hit rate" => Impression.where(controller_name: "pups").where(action_name: "breed").where(created_at: Time.current.all_week).length,
                    "Right mid button hit rate" => Impression.where(controller_name: "pups").where(action_name: "dog_breeder").where(created_at: Time.current.all_week).length,
                    "Rightmost button hit rate" => Impression.where(controller_name: "breeders").where(action_name: "nearer_breeders").where(created_at: Time.current.all_week).length
                    }), library: {animation: {duration: 500, easing: 'easeOutQuad' }}, 
                    donut: true, width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", 
                    title: "Request distribution", animation: "true"
                end
                column do
                    area_chart ({
                        0.day.ago => Impression.where(created_at: 0.day.ago.all_day).length,
                        1.day.ago => Impression.where(created_at: 1.day.ago.all_day).length,
                        2.day.ago => Impression.where(created_at: 2.day.ago.all_day).length,
                        3.day.ago => Impression.where(created_at: 3.day.ago.all_day).length,
                        4.day.ago => Impression.where(created_at: 4.day.ago.all_day).length,
                        5.day.ago => Impression.where(created_at: 5.day.ago.all_day).length,
                        6.day.ago => Impression.where(created_at: 6.day.ago.all_day).length,
                        7.day.ago => Impression.where(created_at: 7.day.ago.all_day).length,
                        }),  
                    library: {animation: {duration: 1000, easing: 'easeOutQuad' }}, 
                    width: "500px", height: "300px", xtitle: "Date", 
                    ytitle: "Population", title: "Request Handled", animation: "true"
                end
            end 
        end
    end
end
