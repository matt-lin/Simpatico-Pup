class ContactBatchMailer < ActionMailer::Base
  default from: 'from@example.com'
  def contact_batch_email(name, email, message, subject, recipient)
    @message = message
    @name = name
    @email = email
    @subject = subject
    @recipient = recipient
    #mail(to: recipient, :reply_to => email, name: @name, subject: @subject)

    mail(to: 'hyu596@berkeley.edu', subject: "Test email", body: "Testing email")
  end
  # def test_email
  #   mail(to: 'hyu596@berkeley.edu', subject: "Test email", body: "Testing email")
  # end
end