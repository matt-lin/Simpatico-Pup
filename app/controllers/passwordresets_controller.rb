#Implementation for Iter2-2 (whole file)

class PasswordresetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  # before_action :valid_user, only: [:edit, :update]
  def new
  end
  
  #dummy create
  def index
    @user = User.find_by(email: params[:email].downcase)
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:notice] = "Email sent with password reset instructions"
    redirect_to root_url
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:notice] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash[:notice] = "Email address not found"
      redirect_to new_passwordreset_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.reset_password_token.nil?
      flash[:notice] = 'Your request to reset password has expired. Refill the form if you want to reset password.'
      render 'new' and return
    end
    if params[:user][:password].empty?                 
      flash[:notice] = 'Password can not be empty'
      render 'edit'
    elsif params[:user][:password_confirmation].empty? 
      flash[:notice] = 'confirmation can not be empty'
      render 'edit'
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash[:notice] = "Password not same as Confirmation"
      render 'edit'    
    elsif @user.update_attributes(user_params)         
      # log_in @user
      flash[:success] = "Password has been reset."
      redirect_to root_path
    else
      flash[:notice] = 'Password must contain more than 8 characters'
      render 'edit'                                    
    end
  end
  
  def user_params
      params.require(:user).permit(:password, :password_confirmation)
  end
  
  # only allow users to reset pw if 
  # 1) within 30 mins
  # 2) must be the last sent reset password url
  # 3) that url has not been used yet 
  def edit
    if params[:email].nil? || params[:token].nil?
      redirect_to root_path and return
    end
    @user = User.find_by(email: params[:email].downcase)
    if ((Time.zone.now - @user.reset_password_sent_at) > 1800) || params[:token] != @user.reset_password_token
      flash[:notice] = 'Your request to reset password has expired. Refill the form if you want to reset password.'
      render 'new'
    else
      @user.update_attribute(:reset_password_token,  '')
    end
  end
  
  # def reset
  #   redirect_to root_path
  # end
  
   private

    def get_user
      @user = User.find_by(email: params[:email])
    end
    # Confirms a valid user<---TODO
    # def valid_user
    #   # may add && @user.activated? later
    #   unless (@user  &&
    #           @user.authenticated?(:reset, params[:id]))
    #     redirect_to root_url
    #   end
    # end
  


end