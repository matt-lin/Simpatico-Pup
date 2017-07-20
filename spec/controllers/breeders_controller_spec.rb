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
      expect(flash[:notice]).to match(/Breeder Alex have been added to our database!*/)
    end
    
    it "tells you the city is invalid" do
      @breeder = FactoryGirl.create(:breeder, :name => "Alex", :city => "HK", :state => "CA")
      post :create, {:breeder => {:name => @breeder.name, :city => @breeder.city, :state => @breeder.state}}
      expect(flash[:notice]).to match(/The city you entered is not a valid city in the selected state. Please re-enter your infomation./)
    end
  end
  
    describe "search a breeder" do
      before :each do
      @breeder = FactoryGirl.create(:breeder)
      @breed = FactoryGirl.create(:breed)
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      post :create, {:breeder => {:name => @breeder.name, :city => @breeder.city, :state => @breeder.state}}
      @temp_pup = Pup.new(:user => @user, :breeder => @breeder, :pup_name => "Doggie", :year => "2", :month => "1",
      :user_id => @user.id, :breeder_id => @breeder.id, :breeder_responsibility => "1", :overall_health => "3",
                  :trainability => "4", :social_behavior => "4",:dog_behavior => "4", :energy_level => "4" , :simpatico_rating => "4")
      end
      
      it "gets all breed" do
      get :search_nearer_breeders
      expect(assigns(:breeds)).to include @breed
      end
      
    it "tells you to select a state" do
    @params = {:breeder => {:breed_name => @temp_pup.pup_name, :city => @breeder.city, :search_distance => 50000, :state => ""}, :format => 'js'}
       xhr :get, :nearer_breeders, @params
      expect(flash[:notice]).to match(/Please select a state/)
      expect(response).to render_template(:nearer_breeders)
    end
   
    it "tells you it is not a valid city" do 
      @params = {:breeder => {:breed_name => @temp_pup.pup_name, :city => "HK", :search_distance => 50000, :state => @breeder.state}, :format => 'js'}
       xhr :get, :nearer_breeders, @params
       expect(flash[:notice]).to match(/The city you entered is not a valid city in the selected state/)
      expect(response).to render_template(:nearer_breeders)
    end
      
    it "joins by breed name and city" do
      @params = {:breeder => {:breed_name => @temp_pup.pup_name, :city => @breeder.city, :search_distance => 50000, :state => @breeder.state}, :format => 'js'}
       xhr :get, :nearer_breeders, @params
      expect(response).to render_template(:nearer_breeders)
   end
    
    it "joins by breed name only" do
      @params = {:breeder => {:breed_name => @temp_pup.pup_name, :search_distance => 50, :state => @breeder.state}, :format => 'js'}
      xhr :get, :nearer_breeders, @params
      expect(response).to render_template(:nearer_breeders)
    end
    
    it "joins by city only" do
      @params = {:breeder => {:city => @breeder.city, :search_distance => 50, :state => @breeder.state}, :format => :js}
      xhr :get, :nearer_breeders, @params
      expect(response).to render_template(:nearer_breeders)
    end
    
    it "joins by breed" do
      @params = {:breeder => {:search_distance => 50, :state => @breeder.state}, :format => :js}
      xhr :get, :nearer_breeders, @params
      expect(response).to render_template(:nearer_breeders)
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
