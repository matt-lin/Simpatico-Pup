class SelectedAttachment < ActiveRecord::Base
  has_many :attachment
  attr_accessible :filename
end
