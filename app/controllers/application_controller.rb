class ApplicationController < ActionController::Base
  protect_from_forgery
  
  ##### :set_titles deleted from before_filter to stop undfined method being created
  before_filter :delete_pup_from_session
  ##########################################
  
######################################################################################
############################for Mobile ###############################################
  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
    end
  end
  helper_method :mobile_device?
end

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  # Render mobile or desktop depending on User-Agent for these actions.
  before_filter :check_for_mobile, :only => [:new, :edit]

  # Always render mobile versions for these, regardless of User-Agent.
  before_filter :prepare_for_mobile, :only => :show
end
##############################################################################  
  def delete_pup_from_session
    if session[:pup]
      session.delete(:pup)
    end
  end

  def set_titles
    @mission = Text.find_by_id(1).title
    @background = Text.find_by_id(2).title
    @goals = Text.find_by_id(3).title
    @how_you_can_help = Text.find_by_id(4).title
  end
  

