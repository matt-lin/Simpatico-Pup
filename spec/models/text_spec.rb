require 'spec_helper'

  describe 'Display name' do
    @text =  FactoryGirl.create(:text, :title => 'Testing', :body => 'body')
    
    it 'returns title field' do
      expect(Text.find_by_name('Testing').body).to eq 'body'
    end
  end
  