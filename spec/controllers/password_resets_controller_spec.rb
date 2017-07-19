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
      describe "should send an email if valid" do
        it "from sign in page" do
          User.should_receive(:find_by).with({:email => "user1@berkeley.edu"}).and_return(User.find(2))
          post :create, {:password_reset => {:email => "user1@berkeley.edu"}}
          expect(flash[:notice]).to eq "Email sent with password reset instructions"
          response.should redirect_to root_path
        end
        it "from edit profile page" do
          User.should_receive(:find_by).with({:email => "user1@berkeley.edu"}).and_return(User.find(2))
          post :index, {:email => "user1@berkeley.edu"}
          expect(flash[:notice]).to eq "Email sent with password reset instructions"
          response.should redirect_to root_path
        end
      end
      it "should re-ask for email if invalid" do
          post :create, {:password_reset => {:email => "invalid@berkeley.edu"}}
          expect(flash[:notice]).to eq "Email address not found"
          response.should redirect_to new_passwordreset_path
      end
      describe "should not be working" do
        it "if the entered new password is empty" do
          put :update, {:id => 2, :user => {:password => "", :password_confirmation => ""}}
          expect(flash[:notice]).to eq 'Password can not be empty'
          response.should render_template 'edit'
        end
        it "if the entered password confirmation is empty" do
          put :update, {:id => 2, :user => {:password => "12345678", :password_confirmation => ""}}
          expect(flash[:notice]).to eq 'confirmation can not be empty'
          response.should render_template 'edit'
        end
        it "if the entered new password is different from password confirmation" do
          put :update, {:id => 2, :user => {:password => "12345678", :password_confirmation => "87654321"}}
          expect(flash[:notice]).to eq 'Password not same as Confirmation'
          response.should render_template 'edit'        
        end
        it "if the entered new password's length is less than 8" do
          put :update, {:id => 2, :user => {:password => "1234", :password_confirmation => "1234"}}
          expect(flash[:notice]).to eq 'Password must contain more than 8 characters'
          response.should render_template 'edit'   
        end
      end
      it "should be working if both passwords are entered correctly" do
        put :update, {:id => 2, :user => {:password => "12345678", :password_confirmation => "12345678"}}
        expect(flash[:success]).to eq 'Password has been reset.'
        response.should redirect_to root_path        
      end
      describe "request should not be available" do
        before :each do
          @user = User.find(2)
        end
        it "if the url has been send for more than 30 mins" do
          @user.update_attribute(:reset_password_sent_at, Time.zone.now - 2000)
          @user.update_attribute(:reset_password_token, 'token')
          get :edit, {:id => 2, :email => 'user1@berkeley.edu', :token => 'token'}
          expect(flash[:notice]).to eq 'Your request to reset password has expired. Refill the form if you want to reset password.'
          response.should render_template 'new'
        end
        it "if that url has been opened already" do
          @user.update_attribute(:reset_password_sent_at, Time.zone.now)
          @user.update_attribute(:reset_password_token, '')
          get :edit, {:id => 2, :email => 'user1@berkeley.edu', :token => 'token'}
          expect(flash[:notice]).to eq 'Your request to reset password has expired. Refill the form if you want to reset password.'
          response.should render_template 'new'
        end
      end
      it "request should only be working if it's never used and sent within 30 mins" do
        @user = User.find(2)
        @user.update_attribute(:reset_password_sent_at, Time.zone.now)
        @user.update_attribute(:reset_password_token, 'token')
        get :edit, {:id => 2, :email => 'user1@berkeley.edu', :token => 'token'}
        response.should render_template 'edit'      
      end
  end

end
