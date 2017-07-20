# Iter 1-2
class ContactBatchMailer < ActionMailer::Base
  default from: 'yuhongzhan0407@berkeley.edu'
  # default from: 'yo@example.com'
  
  def contact_batch_email(name, message, subject, recipient, send)
    if (send == "on")
      @list = SelectedAttachment.get_files
      @list.each do |filename|
        if filename.end_with?(".txt")
          attachments[filename] = File.read(Rails.root.join("app/assets/attachment/#{filename}"))
        else
          attachments.inline[filename] = File.read(Rails.root.join("app/assets/attachment/#{filename}"))
        end
      end
    end
    mail(to: recipient, name: name, subject: subject, body: message)
  end

end
# End for Iter 1-2