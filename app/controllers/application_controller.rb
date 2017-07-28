class ApplicationController < ActionController::Base
  protect_from_forgery 
  
  ##### :set_titles deleted from before_filter to stop undfined method being created
  before_filter :delete_pup_from_session
<<<<<<< HEAD
  
=======
  ##########################################

>>>>>>> 911e94ea37f75461dd3f5fc08ca5a23ba955c013
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
