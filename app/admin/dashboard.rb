ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    columns do
      column do
        panel "Today's Dogs" do
          table_for Pup.where(created_at: Date.today..Date.today.next) do
            column :dog_name do |p|
              link_to p.pup_name, admin_dog_path(p)
            end
            #column :comment do |p|
              #p.comment.content
            #end
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

  end # content
end
