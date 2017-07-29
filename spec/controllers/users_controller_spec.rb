require 'spec_helper'

describe UsersController do
    
    it 'should correctly render pups page' do
        
        @user1 = FactoryGirl.create(:user)
        sign_in :user, @user1
        @dog1 = FactoryGirl.create(:pup, :user_id => @user1.id)
        @dog2 = FactoryGirl.create(:pup, :user_id => @user1.id)
        
        get :pups
        expect(response).to render_template 'pups'
    end
end