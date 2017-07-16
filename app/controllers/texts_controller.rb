class TextsController < ApplicationController
    
    def mission
        @mission_text = Text.find_by_title("Mission")
    end 
    
    def background
        @background_text = Text.find_by_title("Background")
    end 
    
    def goals
        @goals_text = Text.find_by_title("Goals")
    end
    
    def how_you_can_help
        @how_you_can_help_text = Text.find_by_title("How You Can Help")
    end

    def privacy_policy
    end

    def terms_of_service
    end
end
  
