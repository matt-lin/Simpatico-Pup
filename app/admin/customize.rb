# Iter 3-2 (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Customize do
    
    menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }
    content :title => proc{ I18n.t("active_admin.customize") } do
        columns do
          column do
            panel "Today's Dogs" do
              table_for Pup.where(created_at: Date.today..Date.today.next) do
                
              end
            end
          end
        end
      end
    
end
# End for Iter 3-2