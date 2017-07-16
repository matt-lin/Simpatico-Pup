require 'spec_helper'

describe SelectedComment do
  describe "select comments from selected comments" do
    before :each do
      @comment1 = FactoryGirl.create(:selected_comment, :content => 'good dog')
      @comment2 = FactoryGirl.create(:selected_comment, :content => 'bad dog')
    end
    
    it "select a comment randomly from all selected comments" do
        chosen_comment = SelectedComment.find_randomly
        expect(@comment1.content == chosen_comment.content || @comment2.content == chosen_comment.content).to be true
    end
  end
end
