class Attachment < ActiveRecord::Base
    has_attached_file :document
    
    has_attached_file :image
end
