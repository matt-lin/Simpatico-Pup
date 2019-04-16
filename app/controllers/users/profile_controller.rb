class Users::ProfileController < ApplicationController

# /users/profile/edit
def edit_image
  avatar = params[:avatar]

#  if avatar != nil
    flash[:notice] = "You have successfully set your profile image"
    # app/assets/images/default_profile_image.jpg
    current_user.avatar = avatar
    current_user.save!
 # else
  #  flash[:notice] = "Profile image was not entered"
  #end

  redirect_to edit_user_registration_path
end

end
