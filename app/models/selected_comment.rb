class SelectedComment < ActiveRecord::Base
  attr_accessible :content, :user, :breed, :breeder

  def SelectedComment.find_randomly
    count = SelectedComment.count
    if (count > 0)
      offset = rand(count)
      rand_record = SelectedComment.offset(offset).first
      return rand_record
    end
    nil
  end
end
