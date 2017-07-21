class Attachment < ActiveRecord::Base
    belongs_to :selected_comment
    has_attached_file :document, :path => ":rails_root/app/assets/attachment/:basename.:extension"
    do_not_validate_attachment_file_type :document
    
    @@filenames = []
  
    def self.change_files arr
        @@filenames = arr
    end
  
    def self.get_files 
        return @@filenames
    end
    
end
