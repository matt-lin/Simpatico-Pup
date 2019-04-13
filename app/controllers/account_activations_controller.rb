# Iter 2-2 account actication (by Zipei Wang and Jack Chen)
class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && params[:id] == user.activation_digest
      user.activate
      user.save!
      sign_in(user,scope:user)
      flash[:success] = "Congratulations! Your account has been activated!"
      UserMailer.welcome(user).deliver_now
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  def send_mail
    user = User.find_by_email(params[:email])
    
    if user == nil
      redirect_to root_url
      return
    end
    p "*"*80
    p "did create_activation_digest"
    user.create_activation_digest
    user.save!
    user.send_activation_email
    redirect_to new_user_session_path
  end
end
#End for Iter 2-2

