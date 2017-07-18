require 'spec_helper'

describe PasswordresetsController do

  describe "resetting password" do
      before :each do
          5.times.each do |i|
             FactoryGirl.create(:user, email: "user#{i}@berkeley.edu", password: '12345678', password_confirmation: '12345678')
          end
      end
      it "should start with proper page that asks for email" do
          get :new
          response.should render_template 'new'
      end
      it "should send an email if valid" do
          User.should_receive(:find_by).with({:email => "user1@berkeley.edu"}).and_return(User.find(1))
          post :create, {:password_reset => {:email => "user1@berkeley.edu"}}
          response.should redirect_to root_path
          open_email('user1@berkeley.edu')
      end
  end

end
