require 'spec_helper'

describe EmailTemplate do
  before :each do
    @email1 = FactoryGirl.create(:email_template, :title => "Hello!", :body => "Check out our new updates!")
    @email2 = FactoryGirl.create(:email_template, :title => "Good Morning", :body => "Give us some feedback")
  end

  describe 'all_email_templates' do
    it 'return all email templates as array' do
      res = [@email1.title, @email2.title]
      expect(EmailTemplate.all_emails).to eq res
    end
  end

  describe 'is_valid_email' do
    it 'return false for not valid email' do
      expect(EmailTemplate.is_valid_email('random')).to eq false
      expect(EmailTemplate.is_valid_email('another one')).to eq false
    end

    it 'return true for valid email' do
      expect(EmailTemplate.is_valid_email('Hello!')).to eq true
      expect(EmailTemplate.is_valid_email('Good Morning')).to eq true
    end
  end

  describe 'find_by_title' do
    it 'return nil for no matching email' do
      expect(EmailTemplate.find_by_email_field('title', 'Nothing')).to eq nil
    end

    it 'return email matching title' do
      expect(EmailTemplate.find_by_email_field('title', 'Hello!')).to eq @email1
    end
  end

  describe 'find_by_body' do
    it 'return nil for no matching email' do
      expect(EmailTemplate.find_by_email_field('body', 'more random things')).to eq nil
    end

    it 'return email matching body' do
      expect(EmailTemplate.find_by_email_field('body', 'Give us some feedback')).to eq @email2
    end
  end

end
