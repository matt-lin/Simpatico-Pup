class ApplicationController < ActionController::Base
  protect_from_forgery 
  
  ##### :set_titles deleted from before_filter to stop undfined method being created
  before_filter :delete_pup_from_session
  ##########################################
  
  #Iter 3-2 Customize the main page (By Gung Hiu Ho, Licong Wang)
  # @top_left = Customize.find_by_name("Blue_Bar_Top_Left").content
  # @top_mid = Customize.find_by_name("Blue_Bar_Top_Middle").content
  # @top_right = Customize.find_by_name("Blue_Bar_Top_Right").content
  # @bot_left = Customize.find_by_name("Blue_Bar_Bottom_Left").content
  # @bot_mid = Customize.find_by_name("Blue_Bar_Bottom_Middle").content
  # @bot_bot = Customize.find_by_name("Blue_Bar_Bottom_Right").content
  
  def delete_pup_from_session
    if session[:pup]
      session.delete(:pup)
    end
  end
  
  #Haven't found usage of it 
  # def set_titles
  #   @mission = Text.find_by_id(1).title
  #   @background = Text.find_by_id(2).title
  #   @goals = Text.find_by_id(3).title
  #   @how_you_can_help = Text.find_by_id(4).title
  # end
end

