class Comment < ActiveRecord::Base

  belongs_to :pup
  attr_accessible :content
  attr_accessor :breed, :breeder

  validate :comment_length

  def comment_length
    errors.add(:content, 'Limit comments to 140 characters') if content && content.length > 140
  end

end
