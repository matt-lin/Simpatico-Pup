# Iter 1-2
class ContactBatchMailer < ActionMailer::Base
  default from: 'yuhongzhan0407@berkeley.edu'
  # default from: 'yo@example.com'
  
  #Iter 2-2
  def contact_batch_email(name, message, subject, recipient, send)
    if (send == "on")
      Attachment.all.each do |a|
        if a.marked
          if a.document_file_name.end_with?(".txt")
            attachments[a.document_file_name] = File.read("#{a.document.path}")
          else
            attachments.inline[a.document_file_name] = File.read("#{a.document.path}")
          end
        end
      end
    end
    mail(to: recipient, name: name, subject: subject, body: message)
  end
  #End of Iter 2-2

end
# End for Iter 1-2