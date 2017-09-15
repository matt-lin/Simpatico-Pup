# Iter3-2 (Gilbert Lo, Jeff Yu)
class UsersController < ApplicationController

  before_filter :authenticate_user!
  
  def pups
    @pups = Pup.where("user_id = ?", current_user.id)
    session[:from] = 'my_pups'
  end
end
# End Iter3-2
