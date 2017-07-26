require 'spec_helper'

describe SessionsController do
    
    describe "Users" do 
        before :each do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          FactoryGirl.create(:user, email: "user1@berkeley.edu", password: '12345678', password_confirmation: '12345678', activated: true)
          FactoryGirl.create(:user, email: "user2@berkeley.edu", password: '12345678', password_confirmation: '12345678', activated: false)
        end
        it "should go to sign in page if clicking log in" do
          get :new
          response.should render_template 'new'
        end
        it "should get user logged in if activated" do 
          post :create, {:user => {:email => 'user1@berkeley.edu'}}
          response.should be_success
        end
        it "should not sign in if not activated" do
          post :create, {:user => {:email => 'user2@berkeley.edu'}}
          expect(flash[:notice]).to start_with("Account not activated. Check your email for the activation link or click")
          response.should redirect_to root_url
        end
        it "should not sign in if not existing" do
          post :create, {:user => {:email => 'user3@berkeley.edu'}}
          # Devise::SessionsController.should_receive(:create)
          response.should be_success
        end
        
    end
            
end
