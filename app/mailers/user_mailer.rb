class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    ContactBatchMailer.contact_batch_email('reset', 'your_address_to_reply_to@example.com', "passwordreset", "passwordreset", user.email).deliver_now
  end
end
