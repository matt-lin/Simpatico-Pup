class SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user
      if user.activated
        super
      else
        message  = "Account not activated. Check your email for the activation link."
        flash[:notice] = message
        redirect_to root_url
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