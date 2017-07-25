# Iter 1-2
class ContactBatchMailer < ActionMailer::Base
  default from: 'yuhongzhan0407@berkeley.edu'
  # default from: 'yo@example.com'
  
  #Iter 2-2 Improved email (with attachment) (By Gung Hiu Ho, Licong Wang)
  def contact_batch_email(name, message, subject, recipient, send)
    if (send == "on")
      Attachment.all.each do |a|
        attachments[a.document_file_name] = File.read("#{a.document.path}") if a.marked
      end
    end
    mail(to: recipient, name: name, subject: subject, body: message)
  end
  #End of Iter 2-2

end
# End for Iter 1-2