class Comment < ActiveRecord::Base

  belongs_to :pup

  # #Restrict mass assignment (Strong params)
  include ActiveModel::ForbiddenAttributesProtection

  attr_accessor :breed, :breeder

  # attr_accessible :content

  validate :comment_length

  def comment_length
    errors.add(:content, 'Limit comments to 140 characters') if content && content.length > 140
  end

  # private
  def Comment.all_comments
    return Comment.select('content').map{ |e| e.content }.to_a
  end

  def Comment.is_valid_comment(comment)
    Comment.all_comments.include? comment
  end


end
