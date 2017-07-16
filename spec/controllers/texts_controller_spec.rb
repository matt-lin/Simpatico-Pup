require 'spec_helper'

describe TextsController do
    before :each do
        @mission = FactoryGirl.create(:text, :title => "Mission", :body => "Mission Body")
        @background = FactoryGirl.create(:text, :title => "Background", :body => "Background Body")
        @goals = FactoryGirl.create(:text, :title => "Goals", :body => "Goals Body")
        @help = FactoryGirl.create(:text, :title => "How You Can Help", :body => "Help Body")
    end
    
    describe "Render the template and find text" do
        it 'get #mission' do
            get :mission
            expect(response).to render_template('mission')
            expect(assigns(:mission_text)).to eq(@mission)
        end
        
        it 'get #background' do
            get :background
            expect(response).to render_template('background')
            expect(assigns(:background_text)).to eq(@background)
        end
        
        it 'get #goals' do
            get :goals
            expect(response).to render_template('goals')
            expect(assigns(:goals_text)).to eq(@goals)
        end
        
        it 'get #how_you_can_help' do
            get :how_you_can_help
            expect(response).to render_template('how_you_can_help')
            expect(assigns(:how_you_can_help_text)).to eq(@help)
        end
        
        it 'get #privacy_policy' do
            get :privacy_policy
            expect(response).to render_template('privacy_policy')
        end
        
        it 'get #terms_of_service' do
            get :terms_of_service
            expect(response).to render_template('terms_of_service')
        end
    end
end
