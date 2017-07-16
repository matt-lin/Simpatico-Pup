require 'spec_helper'

describe User do
  describe "test if an user is an admin" do
    before :each do
      @admin_user = FactoryGirl.create(:user, :email => 'lhsdvm@aol.com')
      @normal_user = FactoryGirl.create(:user, :email => 'lol@berkeley.edu')
    end
    
    it "check the user's email and tell if it is an admin" do
      expect(@admin_user.admin).to be true
      expect(@normal_user.admin).to be false
      expect(@admin_user.to_s).to eq 'lhsdvm@aol.com'
      expect(@normal_user.to_s).to eq 'lol@berkeley.edu'
    end
  end
end
