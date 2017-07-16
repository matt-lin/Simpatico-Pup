class TextsController < ApplicationController
    
    def mission
        @mission_text = Text.find_by_name "Mission"
    end 
    
    def background
        @background_text = Text.find_by_name "Background"
    end 
    
    def goals
        @goals_text = Text.find_by_name "Goals"
    end
    
    def how_you_can_help
        @how_you_can_help_text = Text.find_by_name "How you can help"
    end

    def privacy_policy
    end

    def terms_of_service
    end
end
  
