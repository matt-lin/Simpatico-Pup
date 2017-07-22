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
    if !user.activated?
      p "*"*80
      p "activated?"
      p "*"*80
    end
    if user
      p "*"*80
      p "user"
      p "*"*80
    end
    if user.authenticated?(:activation, :remember_token)
      p "*"*80
      P "authenticated?"
      p "*"*80
      
    end
    if user && !user.activated?
      
      user.activate
      new_session_path(user)
      p "#{user.email}"
      p "*"*80
      p "user.activated"
      p "#{user.activated?}"
      p "*"*80
      user.save!
      flash[:success] = "Account activated!. Try log_in now!"
      UserMailer.welcome(user).deliver_now
      redirect_to root_path
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end