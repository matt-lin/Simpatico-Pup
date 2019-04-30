class Users::ProfileController < ApplicationController

# /users/profile/edit
def edit_image
  avatar = params[:user][:avatar]

  if avatar != nil
    begin
      current_user.avatar = avatar
      current_user.avatar.recreate_versions!
      current_user.save!
      flash[:notice] = "You have successfully set your profile image!"
    rescue 
      flash[:notice] = "Please submit an image file"
    end
  else
    flash[:notice] = "There was an issue setting your profile image"
  end

  redirect_to edit_user_registration_path
end

end
