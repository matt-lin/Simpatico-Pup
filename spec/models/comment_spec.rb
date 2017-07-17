require 'spec_helper'

describe 'validate comment length' do
  @good_comment = FactoryGirl.create(:comment, :content => 'Testing', :pup_id => 1)

  
    it "should not raise" do
        expect{@good_comment.comment_length}.to_not raise_error()
    end
  
    # it "should raise error" do
    #     expect{@bad_comment.comment_length}.to raise_error
    # end
end
