class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def pups
    @username = current_user.username
  end
end