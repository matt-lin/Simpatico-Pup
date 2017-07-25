#Iter 2-2 Attachment model for file manager (By Gung Hiu Ho, Licong Wang)
class Attachment < ActiveRecord::Base
    belongs_to :selected_comment
    attr_accessible :document
    attr_accessible :catagory
    
    FILE_CATAGORIES = ["Newsletter", "Document", "Image", "Video", "Administive", "Others"]
    
    attachment_virtual_path = "/system/attachments/:rails_env/:hashed_path/:id/:style/:basename.:extension"
    attachment_real_path = ":rails_root/public" + attachment_virtual_path

    has_attached_file :document, :path => attachment_real_path, :url => attachment_virtual_path
    do_not_validate_attachment_file_type :document
end
