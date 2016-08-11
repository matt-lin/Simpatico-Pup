class TextsController < ApplicationController
    
    def mission
        @mission_text = Text.find_by_id(1)
    end 
    
    def background
        @background_text = Text.find_by_id(2)
    end 
    
    def goals
        @goals_text = Text.find_by_id(3)
    end
    
    def how_you_can_help
        @how_you_can_help_text = Text.find_by_id(4)
    end

    def privacy_policy
    end

    def terms_of_service
    end
end
  
