#Iter 2-2 Attachment model for file manager (By Gung Hiu Ho, Licong Wang)
class Attachment < ActiveRecord::Base
    belongs_to :selected_comment
    attr_accessible :document
    attr_accessible :catagory
    
    FILE_CATAGORIES = ["Newsletter", "Document", "Image", "Music", "Video", "Administive", "Others"]
    
    attachment_virtual_path1 = "/system/attachments/:rails_env/:hashed_path/:id/:style/:basename.:extension"
    attachment_real_path1 = ":rails_root/public" + attachment_virtual_path1
    
    # background picture should be saved here
    attachment_virtual_path2 = "/app/assets/images/:basename.:extension"
    attachment_real_path2 = ":rails_root/" + attachment_virtual_path2

    has_attached_file :document, :path => attachment_real_path1, :url => attachment_virtual_path1
    do_not_validate_attachment_file_type :document
end
