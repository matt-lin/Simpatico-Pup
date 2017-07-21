class Attachment < ActiveRecord::Base
    belongs_to :selected_comment
    attachment_virtual_path = "/system/attachments/:rails_env/:hashed_path/:id/:style/:basename.:extension"
    attachment_real_path = ":rails_root/public" + attachment_virtual_path

    has_attached_file :document, :path => attachment_real_path, :url => attachment_virtual_path
    do_not_validate_attachment_file_type :document
    
    @@filenames = []
  
    def self.change_files arr
        @@filenames = arr
    end
  
    def self.get_files 
        return @@filenames
    end
end
