class ContactBatchMailer < ActionMailer::Base
  default from: "simpatico@example.com"
  def contact_batch_email(name, email, message, subject, recipient)
    @message = message
    @name = name
    @email = email
    @subject = subject
    @recipient = recipient
    #mail(to: recipient, :reply_to => email, name: @name, subject: @subject)
    mail(to: "lhygilbert@gmail.com", subject: "Test email", body: "Testing email")
  end
end