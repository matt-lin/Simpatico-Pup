class AccountActivationsController < ApplicationController
  
  #This controller in charges of account activation. 
  
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
  
  # It searches the user using the user email in the database and activate the user account.
  # After the user account has been activated, it directs the user to the home page 
  # and automatically sign in for the user. 
  def edit
    user = User.find_by(email: params[:email])
    
    if user && !user.activated?
      user.activate
      user.save!
      sign_in(user, scope: :user)
      flash[:success] = "Account activated!"
      UserMailer.welcome(user).deliver_now
      redirect_to root_path
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end