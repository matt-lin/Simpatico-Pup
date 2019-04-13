class Customize < ActiveRecord::Base
    attr_accessible :name, :content, :location
    
    @@excluded = ['Title_Button', 'Primary_title', 'Secondary_Title', 'Transition_Button', 'Function_Title']
    @@deleted = false
    
    def Customize.delete
        if !@@deleted
            @@excluded.each do |name|
                if !Customize.find_by_name(name).nil?
                    Customize.find_by_name(name).destroy
                end
            end
            @@deleted = true
        end
    end
end
