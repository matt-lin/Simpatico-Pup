require 'spec_helper'

describe BreedersController do
  describe "looking for all the breeders" do
    it "should retrieve all the breeders" do
      Breeder.should_receive(:all)
      get :index
      response.should render_template "index"
    end
  end
  
  describe "search for breeder" do
    it "should only redirect to root if invalid params" do
      get :search_name, {}
      response.should redirect_to root_path
    end
    
    it "should display flash message since no rating was added" do
      get :search_name, {:breeder => {:name => "Alex"}}
      expect(flash[:notice]).to match(/Sorry, we do not yet have any ratings for Alex*/)
      response.should redirect_to root_path
    end
    
    it "should display breeder info" do
      @breeder = FactoryGirl.create(:breeder)
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      @temp_pup = Pup.new(:user => @user, :breeder => @breeder, :pup_name => "Doggie", :year => "2", :month => "1",
      :user_id => @user.id, :breeder_id => @breeder.id, :breeder_responsibility => "1", :overall_health => "3",
                  :trainability => "4", :social_behavior => "4",:dog_behavior => "4", :energy_level => "4" , :simpatico_rating => "4")
      get :search_name, {:breeder => {:name => "#{@breeder.name} - #{@breeder.city}, #{@breeder.state}"}}
      expect(assigns(:avg_ratings)).to eq @breeder.avg_pup_rating
      expect(assigns(:pups)).to eq @breeder.all_pups
    end
    
    it "should use breeder id to search" do
      @breeder = FactoryGirl.create(:breeder)
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      @temp_pup = Pup.new(:user => @user, :breeder => @breeder, :pup_name => "Doggie", :year => "2", :month => "1",
      :user_id => @user.id, :breeder_id => @breeder.id, :breeder_responsibility => "1", :overall_health => "3",
                  :trainability => "4", :social_behavior => "4",:dog_behavior => "4", :energy_level => "4" , :simpatico_rating => "4")
      get :search_name, {:id => @breeder.id}
      expect(assigns(:avg_ratings)).to eq @breeder.avg_pup_rating
      expect(assigns(:pups)).to eq @breeder.all_pups
    end
  end
  
  describe "creating new breeder" do
    it "should display breeder" do
      @breeder = FactoryGirl.create(:breeder, :name => "Alex", :city => "Berkeley", :state => "CA")
      post :create, {:breeder => {:name => @breeder.name, :city => @breeder.city, :state => @breeder.state}}
      expect(flash[:notice]).to match(/Breeder \#{name} have been added to our database!*/)
    end
  end
  
    describe "search a breeder" do
    it "should display breeder" do
      @breeder = FactoryGirl.create(:breeder)
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      
      post :create, {:breeder => {:name => @breeder.name, :city => @breeder.city, :state => @breeder.state}}
      
      @temp_pup = Pup.new(:user => @user, :breeder => @breeder, :pup_name => "Doggie", :year => "2", :month => "1",
      :user_id => @user.id, :breeder_id => @breeder.id, :breeder_responsibility => "1", :overall_health => "3",
                  :trainability => "4", :social_behavior => "4",:dog_behavior => "4", :energy_level => "4" , :simpatico_rating => "4")
      get :nearer_breeders, {:breeder => {:breed_name => @temp_pup.pup_name, :city => @breeder.city, :search_distance => 50, :state => @breeder.state}}
    end
    
  end

  

  describe "sending json of all breeders" do
    before :each do
      @breeders = (1..10).map do |i|
        FactoryGirl.build(:breeder)
      end
    end

    it "should send all breeders in a json array" do
      Breeder.should_receive(:all).and_return(@breeders)
      xhr :get, :index
      response.body.should == @breeders.to_json
    end

    it "should send a limited number of breeders starting with given string" do
      Breeder.should_receive(:find_by_substring).with("Teddy - Berkeley, CA", 0).and_return(@breeders)
      xhr :get, :search_breeder, {:name => "Teddy - Berkeley, CA", :limit => 0}
      response.body.should == @breeders.to_json
    end

    it "should render an html page if request is not xhr" do
      Breeder.should_receive(:all).and_return(@breeders)
      get :index
      response.should render_template 'index'
    end
  end
end
