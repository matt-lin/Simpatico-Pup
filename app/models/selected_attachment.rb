class SelectedAttachment < ActiveRecord::Base
  attr_accessible :filename

  def SelectedComment.get_filename
    :filename.split('!SPLIT!')
  end
end
