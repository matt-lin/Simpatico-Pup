require 'spec_helper'

describe Feedback do
  before :each do
    @feedback1 = FactoryGirl.create(:feedback, :open_response => 'Good site!', :rate_dog => 2, :breed_rating => 3, :breeder_rating => 4, :forum => 1)
    @feedback2 = FactoryGirl.create(:feedback, :open_response => 'Amazing!', :rate_dog => 4, :breed_rating => 4, :breeder_rating => 4, :forum => 5)
    @feedback3 = FactoryGirl.create(:feedback, :open_response => 'Needs work', :rate_dog => 1, :breed_rating => 1, :breeder_rating => 1, :forum => 1)
  end

  describe 'is_valid_feedback' do
    it 'return false for not valid feedback' do
        expect(Feedback.is_valid_feedback("random stuff")).to eq false
        expect(Feedback.is_valid_feedback("what is this")).to eq false
    end
    it 'return true for valid feedback' do
        expect(Feedback.is_valid_feedback("Good site!")).to eq true
        expect(Feedback.is_valid_feedback("Needs work")).to eq true
    end
  end

  describe 'find_by_rate_dog_score' do
    it 'return nil for no matching feedbacks' do
      expect(Feedback.find_by_score('dog_rating', 5)).to eq nil
    end

    it 'return matched feedbacks' do
      expect(Feedback.find_by_score('dog_rating', 1)).to eq @feedback3
    end
  end

  describe 'find_by_breed_rating_score' do
    it 'return nil for no matching feedbacks' do
      expect(Feedback.find_by_score('breed_rating', 5)).to eq nil
    end

    it 'return matched feedbacks' do
      expect(Feedback.find_by_score('breed_rating', 4)).to eq @feedback2
    end
  end

  describe 'find_by_breeder_rating_score' do
    it 'return nil for no matching feedbacks' do
      expect(Feedback.find_by_score('breeder_rating', 5)).to eq nil
    end

    it 'return matched feedbacks' do
      expect(Feedback.find_by_score('breeder_rating', 4)).to eq @feedback1
    end
  end

  describe 'find_by_forum_score' do
    it 'return nil for no matching feedbacks' do
      expect(Feedback.find_by_score('forum_rating', 2)).to eq nil
    end

    it 'return matched feedbacks' do
      expect(Feedback.find_by_score('forum_rating', 5)).to eq @feedback2
    end
  end

  describe 'all_feedbacks' do
    it 'return all feedback as array' do
      res = [@feedback1.open_response, @feedback2.open_response, @feedback3.open_response]
      expect(Feedback.all_feedbacks).to eq res
    end
  end


end
