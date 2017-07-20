class SelectedAttachment < ActiveRecord::Base
  has_many :attachment
  attr_accessible :filename
  accepts_nested_attributes_for :attachment, allow_destroy: true
end
