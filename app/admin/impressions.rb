ActiveAdmin.register Impression, as: "Site Analysi" do
	
	menu :priority => 12
	menu :label => 'Site Analysis'
	actions :index
	config.batch_actions = false
	config.filters = false
	config.paginate = false
		
		
	index do
		def user_trend(data, title, duration, id)
			area_chart data, library: {animation: {duration: duration, easing: 'easeOutQuad' }},
			width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: title, id: id
		end
		
		def dog_score(data, title, duration, id)
			scatter_chart Pup.group(data).count, library: {animation: {duration: duration, easing: 'easeOutQuad' }},
			width: "500px", height: "300px", xtitle: "Score", ytitle: "Number", title: title, animation: "true", id: id
		end
		
		def pie(data, title, id)
			pie_chart (data), library: {animation: {duration: 500, easing: 'easeOutQuad' }}, 
				donut: true, width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", 
				title: title, id: id
		end
		
		panel "User Statistics" do
			columns do
				column do
					user_trend(User.group_by_day(:created_at).count, "User", 1000, "user")
				end
				column do
					user_trend(NewsletterUser.group_by_day(:created_at).count, "Subscriber Trending", 1000, "subscriber_trending")
				end
			end
			columns do
				column do
					pie({ 
						"Active User" => User.where(last_sign_in_at: (Time.now.midnight - 30.day)..Time.now).length,
						"Inactive User (Inactive for more than 30 Days)" => User.count - User.where(last_sign_in_at: (Time.now.midnight - 30.day)..Time.now).length
						}, "User Activity", "user_activity")
				end
			end
		end
		panel "Pup Statistics" do
			columns do
				column do
					line_chart Pup.group_by_day(:created_at).count, library: {animation: {duration: 1050, easing: 'easeOutQuad' }},
					width: "500px", height: "300px", xtitle: "Date", ytitle: "Number", title: "Pup Creation", animation: "true", id: "pup_creation"
				end
				column do
					column_chart Pup.group(:year).count, library: { animation: {duration: 1050, easing: 'easeOutQuad' }}, discrete: true,
					width: "500px", height: "300px", xtitle: "Year", ytitle: "Number", title: "Age saturation", animation: "true", id: "age_saturation"
				end
			end
			columns do
				column do
					dog_score(:breeder_responsibility, "Breeder Responsibility", 1050, "breeder_responsibility")
				end
				column do
					dog_score(:overall_health, "Overall Health", 1050, "overall_health")
				end
			end
			columns do
				column do
					dog_score(:trainability, "Trainability", 1050, "trainability")
				end
				column do
					dog_score(:social_behavior, "Social Behavior", 1050, "social_behavior")
				end
			end
			columns do
				column do
					dog_score(:energy_level, "Energy level", 1050, "energy_level")
				end
				column do
					dog_score(:simpatico_rating, "Overall rating", 1050, "overall_rating")
					scatter_chart Pup.group(:simpatico_rating).count, library: {animation: {duration: 1050, easing: 'easeOutQuad' }},
					width: "500px", height: "300px", xtitle: "Score", ytitle: "Number", title: "Overall rating", animation: "true", id: "overall_rating"
				end
			end
		end
		panel "Breeder Statistics" do
			columns do
				column do
					area_chart ({
						0.day.ago => Impression.where(controller_name: "breeders.").where(action_name: "create").where(created_at: 0.day.ago.all_day).length,
						1.day.ago => Impression.where(controller_name: "breeders").where(action_name: "create").where(created_at: 1.day.ago.all_day).length,
						2.day.ago => Impression.where(controller_name: "breeders").where(action_name: "create").where(created_at: 2.day.ago.all_day).length,
						3.day.ago => Impression.where(controller_name: "breeders").where(action_name: "create").where(created_at: 3.day.ago.all_day).length,
						4.day.ago => Impression.where(controller_name: "breeders").where(action_name: "create").where(created_at: 4.day.ago.all_day).length,
						5.day.ago => Impression.where(controller_name: "breeders").where(action_name: "create").where(created_at: 5.day.ago.all_day).length,
						6.day.ago => Impression.where(controller_name: "breeders").where(action_name: "create").where(created_at: 6.day.ago.all_day).length,
						7.day.ago => Impression.where(controller_name: "breeders").where(action_name: "create").where(created_at: 7.day.ago.all_day).length,
						}), library: {animation: {duration: 1100, easing: 'easeOutQuad' }},
					width: "500px", height: "300px", xtitle: "Date", ytitle: "Population", title: "Breeder Creation", animation: "true", id: "breeder_creation"
				end
				column do
					geo_chart Breeder.group(:state).count,  library: {region: 'US', resolution: 'provinces'},
					width: "500px", height: "300px", animation: "true", title: "Concentration", id: "concentration"
				end
			end
		end
			
		panel "Site preformance Statistic" do
			columns do
				column do
					pie({ 
					rate_dog_top + " " + rate_Dog_bottom => Impression.where(controller_name: "pups").where(action_name: "create").where(created_at: Time.current.all_week).length,
					find_breed_top + " " + find_breed_bottom => Impression.where(controller_name: "pups").where(action_name: "breed").where(created_at: Time.current.all_week).length,
					find_breeder_top + " " + find_breeder_bottom => Impression.where(controller_name: "pups").where(action_name: "dog_breeder").where(created_at: Time.current.all_week).length,
					search_breeder_top + " " + search_breeder_bottom => Impression.where(controller_name: "breeders").where(action_name: "nearer_breeders").where(created_at: Time.current.all_week).length
					}, "Request distribution", "request_distribution")
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
				ytitle: "Population", title: "Request Handled", animation: "true", id: "request_handled"
				end
			end 
		end
		panel "Storage Statistics" do
			columns do
				column do
					pie(Attachment.group(:catagory).sum(:document_file_size), "Storage Space distribution", "storage_space_distribution")
				end
			end 
		end
	end
end
