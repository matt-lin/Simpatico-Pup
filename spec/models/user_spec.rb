require 'spec_helper'

describe User do
  describe "test if an user is an admin" do
    before :each do
      @admin_user = FactoryGirl.create(:user, :email => 'lhsdvm@aol.com')
      @normal_user = FactoryGirl.create(:user, :email => 'lol@berkeley.edu')
    end
    
    # it "check the user's email and tell if it is an admin" do
    #   @admin_user.admin.should eq true
    #   @normal_user.admin.should eq false
    #   @admin_user.to_s.should eq 'lhsdvm@aol.com'
    #   @normal_user.to_s.should eq 'lol@berkeley.edu'
    # end
  end
  
end