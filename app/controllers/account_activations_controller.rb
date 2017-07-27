# Iter 2-2 account actication (by Zipei Wang and Jack Chen)
class AccountActivationsController < ApplicationController
  def new
    @user = User.new(sign_up_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:notice] = "Please check your email to activate your account."
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated?
      user.activate
      user.save!
      
      sign_in(user,scope:user)
      flash[:success] = "Congratulations! Your account has been activated!"
      UserMailer.welcome(user).deliver_now
      redirect_to root_path
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
#End for Iter 2-2