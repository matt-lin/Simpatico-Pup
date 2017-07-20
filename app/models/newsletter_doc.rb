class Newsletter < ActiveRecord::Base
    has_attached_file :document
end
