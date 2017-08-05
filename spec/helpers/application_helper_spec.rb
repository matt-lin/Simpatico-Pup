require 'spec_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe "bootstrap class" do
    it "returns the correct class according to flash type" do
      bootstrap_class_for(:success).should eq("alert-success")
      bootstrap_class_for(:error).should eq("alert-error")
      bootstrap_class_for(:alert).should eq("alert-block")
      bootstrap_class_for(:notice).should eq("alert-info")
      bootstrap_class_for(:modal).should eq("modal")
    end
  end
  
  describe "text template" do
    
    include ApplicationHelper
    
    before :each do
      FactoryGirl.create(:customize, :name => 'Site_Name', :content => 'Site_name')
      FactoryGirl.create(:customize, :name => 'Primary_Title', :content => 'Primary_Title')
      FactoryGirl.create(:customize, :name => 'Secondary_Title', :content => 'Secondary_Title')
      FactoryGirl.create(:customize, :name => 'Title_Button', :content => 'Find out more')
      
      FactoryGirl.create(:customize, :name => 'Transition_Title', :content => 'Why are we doing this?')
      FactoryGirl.create(:customize, :name => 'Transition_Body', :content => 'At SimpaticoPup.com, we believe that no one should EVER pay money for a puppy unless they verify that the breeder 
        standards listed above are being met. Buying a dog from an irresponsible breeder supports the largely unseen and unregulated industry of 
        puppy mills and profit-motivated breeding.')
      FactoryGirl.create(:customize, :name => 'Transition_Button', :content => 'Get Started')
      
      FactoryGirl.create(:customize, :name => 'Function_leftmost_Top', :content => 'Rate_Dog_Top')    
      FactoryGirl.create(:customize, :name => 'Function_leftmost_Bottom', :content => 'Rate_Dog_Bottom')
      FactoryGirl.create(:customize, :name => 'Function_left_mid_Top', :content => 'Find_Breed_Top')
      FactoryGirl.create(:customize, :name => 'Function_left_mid_Bottom', :content => 'Find_Breed_Bottom')
      FactoryGirl.create(:customize, :name => 'Function_right_mid_Top', :content => 'Find_Breeder_Top')
      FactoryGirl.create(:customize, :name => 'Function_right_mid_Bottom', :content => 'Find_Breeder_Bottom')
      FactoryGirl.create(:customize, :name => 'Function_rightmost_Top', :content => 'Search_Breeder_Top') 
      FactoryGirl.create(:customize, :name => 'Function_rightmost_Bottom', :content => 'Search_Breeder_Bottom')
      
      FactoryGirl.create(:customize, :name => 'Comment_Title', :content => 'Comment_Title')
      
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Top_Left', :content => 'Blue_Bar_Top_Left')
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Top_Middle', :content => 'Blue_Bar_Top_Middle')   
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Top_Right', :content => 'Blue_Bar_Top_Right')    
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Bottom_Left', :content => 'Blue_Bar_Bottom_Left')
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Bottom_Middle', :content => 'Blue_Bar_Bottom_Middle')
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Bottom_Right', :content => 'Blue_Bar_Bottom_Right')
      
      FactoryGirl.create(:customize, :name => 'Nav_Bar_1', :content => 'Mission')
      FactoryGirl.create(:customize, :name => 'Nav_Bar_2', :content => 'Background')   
      FactoryGirl.create(:customize, :name => 'Nav_Bar_3', :content => 'Goals')    
      FactoryGirl.create(:customize, :name => 'Nav_Bar_4', :content => 'How You Can Help')
      FactoryGirl.create(:customize, :name => 'Nav_Bar_5', :content => 'Community Forum')
    end
    
    it "for Site Name" do
      expect(titles).to eq 'Site_name'
    end
    
    it "for primary title" do
      expect(primary_title).to eq 'Primary_Title'
    end
    
    it "for secondary title" do
      expect(secondary_title).to eq 'Secondary_Title'
    end
    
    it "for rate_dog_top" do
      expect(rate_dog_top).to eq 'Rate_Dog_Top'
    end
    
    it "for rate_Dog_bottom" do
      expect(rate_Dog_bottom).to eq 'Rate_Dog_Bottom'
    end
    
    it "for find_breed_top" do
      expect(find_breed_top).to eq 'Find_Breed_Top'
    end
    
    it "for find_breed_bottom" do
      expect(find_breed_bottom).to eq 'Find_Breed_Bottom'
    end
    
    it "for find_breeder_top" do
      expect(find_breeder_top).to eq 'Find_Breeder_Top'
    end    
    
    it "for find_breeder_bottom" do
      expect(find_breeder_bottom).to eq 'Find_Breeder_Bottom'
    end
    
    it "for search_breeder_top" do
      expect(search_breeder_top).to eq 'Search_Breeder_Top'
    end
    
    it "for search_breeder_bottom" do
      expect(search_breeder_bottom).to eq 'Search_Breeder_Bottom'
    end
    
    it "for comment_title" do
      expect(comment_title).to eq 'Comment_Title'
    end  
    
    it "for top_left" do
      expect(top_left).to eq 'Blue_Bar_Top_Left'
    end
    
    it "for top_mid" do
      expect(top_mid).to eq 'Blue_Bar_Top_Middle'
    end
    
    it "for top_right" do
      expect(top_right).to eq 'Blue_Bar_Top_Right'
    end
    
    it "for bot_left" do
      expect(bot_left).to eq 'Blue_Bar_Bottom_Left'
    end  
    
    it "for bot_mid" do
      expect(bot_mid).to eq 'Blue_Bar_Bottom_Middle'
    end
    
    it "for bot_right" do
      expect(bot_right).to eq 'Blue_Bar_Bottom_Right'
    end     
  end
end