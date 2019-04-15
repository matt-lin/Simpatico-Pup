class Users::ProfileController < ApplicationController

# /users/profile/edit
def edit_image
  profile_image = params[:profile_image]

  flash[:notice] = "You have successfully set your profile image"
  redirect_to edit_user_registration_path
end

end
