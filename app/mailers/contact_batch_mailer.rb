# Iter 1-2
class ContactBatchMailer < ActionMailer::Base
  default from: 'yuhongzhan0407@berkeley.edu'
  # default from: 'yo@example.com'
  
  #Iter 2-2
  def contact_batch_email(name, message, subject, recipient, send)
    if (send == "on")
      @filenames = Attachment.get_files
      @filenames.each do |filename|
        if filename.end_with?(".txt")
          attachments[filename] = File.read(Rails.root.join("app/assets/attachment/#{filename}"))
        else
          attachments.inline[filename] = File.read(Rails.root.join("app/assets/attachment/#{filename}"))
        end
      end
    end
    mail(to: recipient, name: name, subject: subject, body: message)
    Attachment.change_files []
    Attachment.all.each do |a|
      a.marked = false
      a.save
    end
  end
  #End of Iter 2-2

end
# End for Iter 1-2