class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def pups
    @username = current_user.username
    @pups = Pup.where("user_id = ?", current_user.id)
  end
end