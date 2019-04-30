require 'spec_helper'

describe NewsletterUser do
  before :each do
    @user1 = FactoryGirl.create(:newsletter_user, :email => "Billy@gmail.com")
    @user2 = FactoryGirl.create(:newsletter_user, :email => "Jim@yahoo.com")
    @user3 = FactoryGirl.create(:newsletter_user, :email => "dog@school.edu")
  end

  describe 'all_newsletter_users' do
    it 'return all newsletter users as array' do
      res = [@user1.email, @user2.email, @user3.email]
      expect(NewsletterUser.all_newsletter_users).to eq res
    end
  end

  describe 'is_valid_newsletter_user' do
    it 'returns false for not valid newsletter user' do
      expect(NewsletterUser.is_valid_newsletter_user("me@gmail.com")).to eq false
      expect(NewsletterUser.is_valid_newsletter_user("random text")).to eq false
    end

    it 'returns true for valid newsletter_user' do
      expect(NewsletterUser.is_valid_newsletter_user("Billy@gmail.com")).to eq true
      expect(NewsletterUser.is_valid_newsletter_user("Jim@yahoo.com")).to eq true
      expect(NewsletterUser.is_valid_newsletter_user("dog@school.edu")).to eq true
    end
  end

  describe 'find_by_email' do
    it 'return nil for no matching newsletter user' do
      expect(NewsletterUser.find_by_email('random text')).to eq nil
      expect(NewsletterUser.find_by_email('me@gmail.com')).to eq nil
    end

    it 'returns matching newsletter user' do
      expect(NewsletterUser.find_by_email('Billy@gmail.com')).to eq @user1
      expect(NewsletterUser.find_by_email('Jim@yahoo.com')).to eq @user2
      expect(NewsletterUser.find_by_email('dog@school.edu')).to eq @user3
    end
  end

end
