class Attachment < ActiveRecord::Base
    has_attached_file :document, :path => ":rails_root/app/assets/attachment/:basename.:extension"
    do_not_validate_attachment_file_type :document
end
