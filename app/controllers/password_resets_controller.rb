class PasswordResetsController < ApplicationController
  def new
    flash[:notice] = 'Email sent with password reset instructions'
    
    redirect_to edit_user_registration_path
  end

  def edit
  end
end
