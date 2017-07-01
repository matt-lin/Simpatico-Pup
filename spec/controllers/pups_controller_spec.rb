require 'spec_helper'

describe PupsController do
  describe "looking at all pups" do
    it "should get all of the dogs" do
      Pup.should_receive(:all)
      get :index
      response.should render_template 'index'
    end
  end
  # describe "page for submitting new review" do
  #   it "should get all of the breeds for the page" do
  #     Pup.should_receive(:all_breeds).and_return([])
  #     Pup.should_receive(:all_breeds_none).and_return([])
  #     get :new
  #   end
  # end
  describe "serving main page" do
    it "should get all of the breeds for the page" do
      Pup.should_receive(:all_breeds).and_return([])
      Pup.should_receive(:all_breeds_none).and_return([])
      Breeder.should_receive(:all).and_return([])
      get :main
    end
  end
  describe "looking at a single pup review" do
    it "should find the pup" do
      temp_pup = Pup.new()
      Pup.should_receive(:find).with('1').and_return(temp_pup)
      get :show, :id => 1
    end
  end
  describe "creating a pup review" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      @temp_pup = Pup.new()
      @breeder = FactoryGirl.create(:breeder)
      @pup_hash = {:pup =>
         {
          :breeder_id => @breeder.id,
          :breeder_responsibility => "1",
          :pup_name => "Doge",
          :breed_1 => "Shiba Inu",
          :breed_2 => "None",
          :overall_health => "1",
          :trainability => "1",
          :social_behavior => "1",
          :energy_level => "1",
          :simpatico_rating => "1",
          :comments => "DOPE CITY"
        },
         :breeder => {
             :name => @breeder.name,
             :city => @breeder.city,
             :state => @breeder.state
         }
      }
      @breeder_nonexist_hash = {:pup =>
         {
          :breeder_id => -1,
          :breeder_responsibility => "1",
          :pup_name => "Doge",
          :breed_1 => "Shiba Inu",
          :breed_2 => "None",
          :overall_health => "1",
          :trainability => "1",
          :social_behavior => "1",
          :energy_level => "1",
          :simpatico_rating => "1",
          :comments => "DOPE CITY"
        },
         :breeder => {
             :name => "John",
             :city => "Seattle",
             :state => "WA"
         }
      }
    end
    it "should redirect to new pup page if fields are incomplete" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1" 
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      post :create, {:pup => {:overall_health => ''}}
      response.should redirect_to new_pup_path
      flash[:notice].should eq("Please make sure all fields are complete!")
    end
    it "should redirect to root page if correct fields are provided" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1" 
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      post :create, @pup_hash
      response.should redirect_to root_path
      flash[:notice].should eq("Thank You! Doggie was successfully added to our database.")
    end
    # it "should auto create one according to input breeder info if breeder not exist" do
    #   session[:step1] = true
    #   session[:pup_name] = "Doggie"
    #   session[:step2] = true
    #   session[:years] = "1" 
    #   session[:months] = "1"
    #   session[:step3] = true
    #   session[:breed] = "Affenpinscher"
    #   post :create, @breeder_nonexist_hash
    #   response.should redirect_to root_path
    # end
    it "should go to dog_how_long if name is provided" do
      get :dog_how_long, {:pup=>{:pup_name=>"Doggie"}}
      expect(response).to render_template(:dog_how_long)
      expect(session[:pup_name]).to eq("Doggie")
      expect(session[:step1]).to be_true
    end
    it "should redirect to do_name if name is not provided" do
      get :dog_how_long, {:pup=>{:pup_name=>""}}
      expect(response).to redirect_to dog_name_path
      expect(session[:step1]).to be_false
    end
    it "should go to dog_breed if years and months provided and valid" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      get :dog_breed, {:pup=>{:years=>"1",:months=>"1"}}
      expect(response).to render_template(:dog_breed)
      expect(session[:step2]).to be_true
    end
    it "should redirect popup a modal if years and months not valid" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      get :dog_breed, {:pup=>{:years=>"",:months=>"3"}}
      expect(response).to redirect_to dog_how_long_path(:pup=>{:pup_name=>"Doggie"})
      expect(flash[:modal]).to eq("To keep our database as accurate as possible,
we are collecting information only for dogs that have been residing 
in their current home for six months or more. Please come back to our 
site and rate your dog after s/he has lived 
with you for a minimum of six months. Thank you.")
      expect(session[:step2]).to be_false
    end
    it "should redirect to dog_how_long if years and months not provided" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      get :dog_breed, {:pup=>{:years=>"",:months=>""}}
      expect(response).to redirect_to dog_how_long_path(:pup=>{:pup_name=>session[:pup_name]})
      expect(session[:step2]).to be_false
    end
    it "should redirect to root page if any previous step not finished(step breed)" do
      session[:step1] = false
      get :dog_breed, {:pup=>{:years=>"1",:months=>"1"}}
      expect(response).to redirect_to root_path
    end
    it "should go to dog_breeder if Purebred " do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1" 
      session[:months] = "1"
      get :dog_breeder, {:button_clicked => "Next", :breed => {:name => "Affenpinscher"}}
      expect(response).to render_template(:dog_breeder)
      expect(session[:step3]).to be_true
      expect(session[:breed]).to eq("Affenpinscher")
    end
    it "should redirect to root if not purebred" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1" 
      session[:months] = "1"
      get :dog_breeder, {:button_clicked => "Breed Not Listed", :breed => {:name => "Affenpinscher"}}
      expect(response).to redirect_to root_path
      expect(session[:step3]).to be_false
    end
    it "should redirect to root page if any previous step not finished(step breeder)" do
      session[:step1] = false
      get :dog_breeder, {:button_clicked => "Next", :breed => {:name => "Affenpinscher"}}
      expect(response).to redirect_to root_path
    end
    # it "should go to new rating page if breeder name provided" do
    #   session[:step1] = true
    #   session[:pup_name] = "Doggie"
    #   session[:step2] = true
    #   session[:years] = "1" 
    #   session[:months] = "1"
    #   session[:step3] = true
    #   session[:breed] = "Affenpinscher"
    #   get :new, {:breeder=>{:new=>"new"}, :new_breeder=>{:name=>"BreedMaster", :city=>"Berkeley", :state=>"CA"}}
    #   expect(response).to render_template(:new)
    # end
    # it "should go to new rating even if no breeder provided" do
    #   session[:step1] = true
    #   session[:pup_name] = "Doggie"
    #   session[:step2] = true
    #   session[:years] = "1" 
    #   session[:months] = "1"
    #   session[:step3] = true
    #   session[:breed] = "Affenpinscher"
    #   get :new, {:button_clicked => "Next", :breeder=>{:name=>""}}
    #   expect(response).to render_template(:new)
    # end
    it "should redirect to root page if any previous step not finished(step new)" do
      session[:step1] = false
      get :new, {:button_clicked => "Next", :breeder=>{:name=>""}}
      expect(response).to redirect_to root_path
    end
  end
  describe "updating a review" do
    it "should find the pup and update it's attributes" do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      temp_pup = Pup.new()
      Pup.should_receive(:find).with('1').and_return(temp_pup)
      temp_pup.should_receive(:update_attributes).with({})
      put :update, {:id => 1, :pup => {}}
      response.should redirect_to pups_path
    end
  end
  describe "deleting a pup rating" do
    it "should find the pup and destroy it's review" do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      temp_pup = Pup.new()
      Pup.should_receive(:find).with('1').and_return(temp_pup)
      temp_pup.should_receive(:destroy)
      delete :destroy, :id => 1
      response.should redirect_to pups_path
    end
  end
  describe "searching a dog by breed" do
    it "should find dogs with the single breed submitted" do
      fake_dogs = [double('pup1'), double('pup2'), double('pup3')]
      Pup.should_receive(:find_by_breeds).with('shiba inu', 'None').and_return(fake_dogs)
      avg_ratings = {
        'breeder_responsibility'=> 1,
        'overall_health' => 1,
        'trainability' => 1,
        'social_behavior' => 1,
        'energy_level' => 1,
        'simpatico_rating' => 1
      }
      Pup.should_receive(:avg_ratings_by_breeds).with('shiba inu', 'None').and_return(avg_ratings)
      get :breed, {:breed => {:name => 'shiba inu'}}
    end
    it "should redirect to the main page when there are no results" do
      Pup.stub(:find_by_breeds).with('shiba inu', 'None').and_return([])
      Pup.should_receive(:avg_ratings_by_breeds).never
      get :breed, {:breed => {:name => 'shiba inu'}}
      response.should redirect_to root_path
    end
  end
end