class SelectedAttachment < ActiveRecord::Base
  has_many :attachment
  accepts_nested_attributes_for :attachment, allow_destroy: true
  
  @@filenames = []
  
  def self.change_files arr
    @@filenames = arr
  end
  
  def self.get_files 
    return @@filenames
  end
  
end
