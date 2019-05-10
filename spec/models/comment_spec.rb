require 'spec_helper'

describe Comment do
  before :each do
    @comment1 = FactoryGirl.create(:comment, :content => "Awesome dog!")
    @comment2 = FactoryGirl.create(:comment, :content => "Hard to work with")
    @comment3 = FactoryGirl.create(:comment, :content => "Wow")
  end

  describe "all_comments" do
    it 'returns all comments as array' do
      res = [@comment1.content, @comment2.content, @comment3.content]
      expect(Comment.all_comments).to eq res
    end
  end

  describe 'is_valid_comment' do
    it 'return false for not valid comment' do
      expect(Comment.is_valid_comment("random comment")).to eq false
      expect(Comment.is_valid_comment("could be better")).to eq false

    end

    it 'return true for valid comment' do
      expect(Comment.is_valid_comment("Awesome dog!")).to eq true
      expect(Comment.is_valid_comment("Hard to work with")).to eq true
      expect(Comment.is_valid_comment("Wow")).to eq true

    end
  end
end
