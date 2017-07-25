class Customize < ActiveRecord::Base
    attr_accessible :welcome1, :welcome2
    
    @@texts = {
     "welcome1" => "ha",
     "welcome2" => "haha"
    }
end
