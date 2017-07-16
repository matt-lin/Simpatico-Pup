class ContactBatchMailer < ActionMailer::Base
  default from: 'yuhongzhan0407@berkeley.edu'
  # default from: 'yo@example.com'
  
  def contact_batch_email(name, message, subject, recipient)
    mail(to: recipient, name: name, subject: subject, body: message)
  end

end