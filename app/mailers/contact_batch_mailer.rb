class ContactBatchMailer < ActionMailer::Base
  default from: 'yuhongzhan0407@berkeley.edu'
  # default from: 'yo@example.com'
  
  def contact_batch_email(name, email, message, subject, recipient)
    # @message = message
    # @name = name
    # @email = email
    # @subject = subject
    # @recipient = recipient
    mail(to: recipient, name: name, subject: subject, body: message)
    # mail(to: 'lhygilbert@gmail.com', subject: "Test email", body: "Testing email")
  end
  # def test_email
  #   mail(to: 'hyu596@berkeley.edu', subject: "Test email", body: "Testing email")
  # end
end