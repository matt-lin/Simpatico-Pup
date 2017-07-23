class AccountActivationsController < ApplicationController
  
  
  def new
    # build_resource(sign_up_params)
    # resource.save
    @user = User.new(sign_up_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:notice] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    user = User.find_by(email: params[:email])
    
    if user && !user.activated?
      user.activate
      user.save!
      
      flash[:success] = "Account activated!. Try log in now!"
      UserMailer.welcome(user).deliver_now
      redirect_to root_path
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end