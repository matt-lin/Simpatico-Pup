class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    @url = "cs169-intro-hyu596.c9users.io/passwordresets/#{@user.id}/edit"
    mail(to: user.email,  subject: 'Reset Password')
  end
end
