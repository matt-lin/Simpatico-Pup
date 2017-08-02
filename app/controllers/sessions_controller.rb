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
      else
        user.create_activation_digest
        message  = "Account not activated. A new account activation has been send.<a href='#{user.send_activation_email}'>here</a>".html_safe
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