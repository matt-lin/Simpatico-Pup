# Iter 3-2 (Gilbert Lo, Jeff Yu)
class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def pups
    @pups = Pup.where("user_id = ?", current_user.id)
  end
end
# End iter 3-2
