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

  def index
    user_id = params[:user_id]
    if not User.exists?(user_id)
      redirect_to "/"
      return
    end
    @user = User.find(user_id)
    if @user.bio.nil? or @user.bio.empty?
      @bio = "No biography" #TODO Add empty biography message
    else
      @bio = @user.bio
    end
    @pups = Pup.where("user_id = ?", user_id)
    @is_current_user = !current_user.nil? and user_id.to_i == current_user.id
  end

  def bio
    current_user.bio = params[:user][:bio]
    if current_user.save
      flash[:notice] = "You have successfully updated your biography"
    else
      flash[:notice] = "There was an error setting you biography"
    end

    redirect_to edit_user_registration_path
  end
end
