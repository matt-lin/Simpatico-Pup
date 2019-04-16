class Users::ProfileController < ApplicationController

# /users/profile/edit
def edit_image
  avatar = params[:user][:avatar]

  if avatar != nil
    flash[:notice] = "You have successfully set your profile image"
    current_user.avatar = avatar
    current_user.save!
  else
    flash[:notice] = "There was an issue setting your profile image"
  end

  redirect_to edit_user_registration_path
end

end
