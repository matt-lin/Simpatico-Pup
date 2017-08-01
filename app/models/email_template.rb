class EmailTemplate < ActiveRecord::Base
    #Iter3-2 restricted assignment (By Gung Hiu Ho)
    attr_accessible :title
    attr_accessible :body
    attr_accessible :created_at
    attr_accessible :updated_at
    attr_accessible :marked
end