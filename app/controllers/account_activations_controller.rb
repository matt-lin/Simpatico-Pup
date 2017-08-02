# Iter 2-2 account actication (by Zipei Wang and Jack Chen)
class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    p "*" * 80
    p user
    p "#{user.authenticated?(:activation, params[:id])} <-- user"
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
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