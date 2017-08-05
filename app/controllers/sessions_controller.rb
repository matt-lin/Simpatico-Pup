class SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    # super
    user = User.find_by(email: params[:user][:email].downcase)
    if user
      if user.activated
        super
      elsif user.valid_password?(params[:user][:password])
          message = "Account hasn't been activated. Please verify your email before continue. Click <a href='#{url_for activate_path(user.email)}'>here</a> to resend email."
          flash[:notice] = message
          redirect_to new_user_session_path
      else
        super
      end
    else  
      super
    end
  end
  

  # def destroy
  #   log_out if logged_in?
  #   redirect_to root_url
  # end
end