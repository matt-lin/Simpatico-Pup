# Iter 2-2 account actication (by Zipei Wang and Jack Chen)
class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    p "*" * 80
    p params[:id]
    p user.activation_digest
    p "*" * 80
    if user && !user.activated? && params[:id] == user.activation_digest
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