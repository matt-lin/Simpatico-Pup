class UserMailer < ApplicationMailer

  def account_activation(user)
    p"sdf"
    p "#{user}"
    p "%"*80
    
    @user = user 
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
  def welcome(user)
    @user = user
    mail to: user.email, subject: "Welcome"
  end
end
