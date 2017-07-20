class Newsletter < ActiveRecord::Base
    has_attached_file :document
    validates_attachment_content_type :document, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
