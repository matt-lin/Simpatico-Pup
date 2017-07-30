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
      FactoryGirl.create(:customize, :name => 'Rate_Dog_Top', :content => 'Rate_Dog_Top')    
      FactoryGirl.create(:customize, :name => 'Rate_Dog_Bottom', :content => 'Rate_Dog_Bottom')
      FactoryGirl.create(:customize, :name => 'Find_Breed_Top', :content => 'Find_Breed_Top')
      FactoryGirl.create(:customize, :name => 'Find_Breed_Bottom', :content => 'Find_Breed_Bottom')
      FactoryGirl.create(:customize, :name => 'Find_Breeder_Top', :content => 'Find_Breeder_Top')
      FactoryGirl.create(:customize, :name => 'Find_Breeder_Bottom', :content => 'Find_Breeder_Bottom')
      FactoryGirl.create(:customize, :name => 'Search_Breeder_Top', :content => 'Search_Breeder_Top') 
      FactoryGirl.create(:customize, :name => 'Search_Breeder_Bottom', :content => 'Search_Breeder_Bottom')
      FactoryGirl.create(:customize, :name => 'Comment_Title', :content => 'Comment_Title')
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Top_Left', :content => 'Blue_Bar_Top_Left')
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Top_Middle', :content => 'Blue_Bar_Top_Middle')   
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Top_Right', :content => 'Blue_Bar_Top_Right')    
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Bottom_Left', :content => 'Blue_Bar_Bottom_Left')
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Bottom_Middle', :content => 'Blue_Bar_Bottom_Middle')
      FactoryGirl.create(:customize, :name => 'Blue_Bar_Bottom_Right', :content => 'Blue_Bar_Bottom_Right')
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