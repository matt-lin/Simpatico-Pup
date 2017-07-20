# Iter 1-2
class ContactBatchMailer < ActionMailer::Base
  default from: 'yuhongzhan0407@berkeley.edu'
  # default from: 'yo@example.com'
  
  def contact_batch_email(name, message, subject, recipient, send)
    if (send == "on")
      attachments.inline['Resume.pdf'] = File.read(Rails.root.join('app/assets/attachment/Resume.pdf'))
    end
    mail(to: recipient, name: name, subject: subject, body: message)
  end

end
# End for Iter 1-2