class SelectedAttachment < ActiveRecord::Base
  has_many :attachment
  accepts_nested_attributes_for :attachment, allow_destroy: true
end
