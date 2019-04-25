require 'spec_helper'

describe PupsController do
  # Iter3-2 Setup the default layout for homepage (By Gung Hiu Ho, Licong Wang)
  before :each do
    layouts = {
      Site_Name: ['SimpaticoPup', 'site_title'],
      Primary_Title: ['Better Way to Find a Great Dog', 'main_title'],
      Secondary_Title: ['Find Dog Breeders Near You', 'main_title'],
      Rate_Dog_Top: ['Rate your','main_button'],
      Rate_Dog_Bottom: ['Dog','main_button'],
      Find_Breed_Top: ['Find Ratings for a', 'main_button'],
      Find_Breed_Bottom: ['Breed', 'main_button'],
      Find_Breeder_Top: ['Find Ratings for a', 'main_button'],
      Find_Breeder_Bottom: ['Breeder', 'main_button'],
      Search_Breeder_Top: ['Search for a', 'main_button'],
      Search_Breeder_Bottom: ['Breeder', 'main_button'],
      Blue_Bar_Top_Left: ['For More Information on Breed Health', 'main_bar'],
      Blue_Bar_Top_Middle: ['Privacy Policy', 'main_bar'],
      Blue_Bar_Top_Right: ['Contact Info', 'main_bar'],
      Blue_Bar_Bottom_Left: ['Canine Health Information Center', 'main_bar'],
      Blue_Bar_Bottom_Middle: ['Terms of Service', 'main_bar'],
      Blue_Bar_Bottom_Right: ['LSandersDVM@gmail.com', 'main_bar'],
      Comment_Title: ['Featured Comment', 'main_title'],
      Nav_Bar_1: ['Mission', 'navigation_bar'],
      Nav_Bar_2: ['Background', 'navigation_bar'],
      Nav_Bar_3: ['Goals', 'navigation_bar'],
      Nav_Bar_4: ['How You Can Help', 'navigation_bar'],
      Nav_Bar_5: ['Community Forum', 'navigation_bar'],
      Nav_Bar_6: ['Feedback', 'navigation_bar']}

    layouts.keys.each do |key|
      Customize.create!(name: key, content: layouts[key][0], location: layouts[key][1])
    end
  end
  # End of Iter3-2

  describe "showing home page" do
    it "should set up for main page" do
      content = "Comment content"
      breed = "RandomBreed"
      FactoryGirl.create(:selected_comment, :content => content, :breed => breed)
      get :main
      response.should render_template 'main'
      expect(assigns(:comment_content)).to eq content
      expect(assigns(:comment_breed)).to eq breed

      expect(session[:step1]).to be_false
      expect(session[:step2]).to be_false
      expect(session[:step3]).to be_false
      expect(session[:pup_name]).to be_nil
      expect(session[:breed]).to be_nil
      expect(session[:years]).to be_nil
      expect(session[:months]).to be_nil
      expect(session[:breeder_id]).to be_nil
    end
  end

  describe "looking at all pups" do
    it "should get all of the dogs" do
      get :index
      response.should redirect_to root_path
    end
  end

  describe "looking at a single pup review" do
    before :each do
      @user1 = FactoryGirl.create(:user)
      sign_in :user, @user1
      @dog1 = FactoryGirl.create(:pup, :user_id => @user1.id)
    end

    it "should find the pup if dog exist and user is the owner" do
      get :show, :id => @dog1.id
      expect(response).to render_template 'show'
      expect(assigns(:pup)).to eq @dog1
    end

    it "should redirect to root_path if pup not exist" do
      get :show, :id => 2
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to_not be_empty
    end

    it "should redirect to root_path if the user does not own the dog" do
      user2 = FactoryGirl.create(:user, :email => "user2@test.com")
      sign_in :user, user2
      get :show, :id => @dog1.id
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to_not be_empty
    end
  end

  describe "creating a pup review without logging in" do
    it "calling dog name should redirect to welcome_path" do
      get :dog_name
      expect(response).to redirect_to welcome_path
    end

    it "calling dog how long should redirect to welcome_path" do
      post :dog_how_long
      expect(response).to redirect_to welcome_path
    end

    it "calling dog breed should redirect to welcome_path" do
      post :dog_breed
      expect(response).to redirect_to welcome_path
    end

    it "calling dog breeder should redirect to welcome_path" do
      post :dog_breeder
      expect(response).to redirect_to welcome_path
    end

    it "calling dog new should redirect to welcome_path" do
      post :new
      expect(response).to redirect_to welcome_path
    end
  end

  describe "creating a pup review" do
    before :each do
      unknown_breeder = FactoryGirl.create(:breeder, :name => "Unknown")
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      @temp_pup = Pup.new()
      @breeder = FactoryGirl.create(:breeder)
      session[:breeder_id] = @breeder.id
      @pup_hash = {:pup =>
        {
          # :breeder_id => @breeder.id,
          :breeder_responsibility => "1",
          :name => "Doge",
          :breed_1 => "Shiba Inu",
          :breed_2 => "None",
          :overall_health => "1",
          :trainability => "1",
          :social_behavior => "1",
          :energy_level => "1",
          :simpatico_rating => "1",
          :comments => "DOPE CITY",
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
          :name => "Doge",
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
      FactoryGirl.create(:breed, :name => 'Affenpinscher')
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      Pup.stub(:build_pup) {Pup.new(:pup_id => @user.id)}
      post :create, {:pup => {:overall_health => ''}}
      response.should redirect_to new_pup_path
      flash[:notice].should eq("Please make sure all fields are complete!")
    end

    it "should redirect to root page if correct fields are provided" do
      FactoryGirl.create(:breed, :name => 'Affenpinscher')
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      stub_pup = Pup.new(:overall_health => "1", :trainability => "1", :social_behavior => "1", :energy_level => "1",
            :simpatico_rating => "1", :breeder_responsibility => "1", :breed_id => 1, :breeder_id => 1, :pup_name => session[:pup_name],
            :year => session[:years], :month => session[:months], :user_id => @user.id)
      Pup.stub(:build_pup) {stub_pup}
      post :create, @pup_hash
      response.should redirect_to root_path
      flash[:notice].should eq("Thank You! Doggie was successfully added to our database. Let us know how we're <a href='#{feedback_path}'>doing</a>!")
    end

    it "should redirect to rating page if comment is too long" do
      FactoryGirl.create(:breed, :name => 'Affenpinscher')
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      @pup_hash[:pup][:comments] = "*" * 200
      stub_pup = Pup.new(:overall_health => "1", :trainability => "1", :social_behavior => "1", :energy_level => "1",
            :simpatico_rating => "1", :breeder_responsibility => "1", :breed_id => 1, :breeder_id => 1, :pup_name => session[:pup_name],
            :year => session[:years], :month => session[:months], :user_id => @user.id)
      Pup.stub(:build_pup) {stub_pup}
      post :create, @pup_hash
      response.should redirect_to new_pup_path
      flash[:notice].should eq('Please make sure the comment is less than 140 characters.')
    end

    it "should redirect to main page if same user rate more than 8 dog" do
      FactoryGirl.create(:breed, :name => 'Affenpinscher')
      9.times do
        FactoryGirl.create(:pup, :user_id => @user.id)
      end
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      stub_pup = Pup.new(:overall_health => "1", :trainability => "1", :social_behavior => "1", :energy_level => "1",
            :simpatico_rating => "1", :breeder_responsibility => "1", :breed_id => 1, :breeder_id => 1, :pup_name => session[:pup_name],
            :year => session[:years], :month => session[:months], :user_id => @user.id)
      Pup.stub(:build_pup) {stub_pup}
      post :create, @pup_hash
      expect(response).to redirect_to root_path
    end

    it "should go to root_path if user rate to many dog already (step 1)" do
      9.times do
        FactoryGirl.create(:pup, :user_id => @user.id)
      end
      get :dog_name
      expect(response).to redirect_to root_path
    end

    it "should go to dog_how_long if name is provided" do
      get :dog_how_long, {:pup=>{:name=>"Doggie"}}
      expect(response).to render_template(:dog_how_long)
      expect(session[:pup_name]).to eq("Doggie")
      expect(session[:step1]).to be_true
    end

    it "should redirect to do_name if name is not provided" do
      get :dog_how_long, {:pup=>{:name=>""}}
      expect(response).to redirect_to dog_name_path
      expect(session[:step1]).to be_false
    end

    it "should use session if pup name is not in params" do
      session[:pup_name] = "doggy"
      get :dog_how_long
      expect(response).to render_template(:dog_how_long)
    end

    it "should go to dog_breed if years and months provided and valid" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      get :dog_breed, {:pup=>{:years=>"1",:months=>"1"}}
      expect(response).to render_template(:dog_breed)
      expect(session[:step2]).to be_true
    end

    it "should go to dog_how_long if years and months are not number" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      get :dog_breed, {:pup=>{:years=>"sad",:months=>"tret"}}
      expect(response).to redirect_to dog_how_long_path(:pup=>{:name=>"Doggie"})
      expect(flash[:notice]).to eq("Please enter a valid integer number for year/month.")
    end

    it "should redirect popup a modal if years and months not valid" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      get :dog_breed, {:pup=>{:years=>"",:months=>"3"}}
      expect(response).to redirect_to dog_how_long_path(:pup=>{:name=>"Doggie"})
      expect(flash[:modal]).not_to be_empty
      expect(session[:step2]).to be_false
    end

    it "should redirect to dog_how_long if years and months not provided" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      get :dog_breed, {:pup=>{:years=>"",:months=>""}}
      expect(response).to redirect_to dog_how_long_path(:pup=>{:name=>session[:pup_name]})
      expect(session[:step2]).to be_false
    end

    it "should redirect to root page if any previous step not finished(step breed)" do
      session[:step1] = false
      get :dog_breed, {:pup=>{:years=>"1",:months=>"1"}}
      expect(response).to redirect_to root_path
    end

    it "should use session to store how long if params not available" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:years] = "1"
      session[:months] = "2"
      get :dog_breed
      expect(response).to render_template(:dog_breed)
      expect(session[:step2]).to be_true
    end

    it "should go to dog_breeder if Purebred " do
      FactoryGirl.create(:breed, :name => 'Affenpinscher')
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
      session[:step1] = false
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

    it "should use session if params not available" do
      FactoryGirl.create(:breed, :name => 'Affenpinscher')
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:breed] = "Affenpinscher"
      get :dog_breeder, {:button_clicked => "Next"}
      expect(response).to render_template(:dog_breeder)
      expect(session[:step3]).to be_true
      expect(session[:breed]).to eq("Affenpinscher")
    end

    it "should redirect to dog_breed_path if breed is not valid" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      get :dog_breeder, {:button_clicked => "Next", :breed => {:name => "fake breed"}}
      expect(response).to redirect_to dog_breed_path
      expect(session[:step3]).to be_false
    end

    it "should go to new rating page if breeder name provided and breeder exist" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      get :new, {:breeder => {:name => "Teddy Roosevelt - Berkeley, CA"}}
      expect(response).to render_template(:new)
    end

    it "should go to new rating even if no breeder provided" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      get :new, {:button_clicked => "Next", :breeder=>{:name=>""}}
      expect(response).to render_template(:new)
    end

    it "should redirect to main page if same user rate same breeder more than once" do
      FactoryGirl.create(:pup, :user_id => @user.id, :breeder_id => @breeder.id)
      FactoryGirl.create(:pup, :user_id => @user.id, :breeder_id => @breeder.id)
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      get :new, {:breeder => {:name => "Teddy Roosevelt - Berkeley, CA"}}
      expect(response).to redirect_to root_path
    end

    it "should ask to add a breeder if breeder doesn't exist" do
      session[:step1] = true
      session[:pup_name] = "Doggie"
      session[:step2] = true
      session[:years] = "1"
      session[:months] = "1"
      session[:step3] = true
      session[:breed] = "Affenpinscher"
      get :new, {:button_clicked => "Next", :breeder=>{:name=>"fake breeder"}}
      expect(response).to redirect_to new_breeder_path
    end

    it "should redirect to root page if any previous step not finished(step new)" do
      session[:step1] = false
      get :new, {:button_clicked => "Next", :breeder=>{:name=>""}}
      expect(response).to redirect_to root_path
    end
  end

  describe "updating a review" do
    before :each do
      @user1 = FactoryGirl.create(:user)
      sign_in :user, @user1
      @dog1 = FactoryGirl.create(:pup, :user_id => @user1.id)
    end

    it "should find the pup and update it's attributes" do
      temp_pup = Pup.new()
      temp_breed = Breed.new()
      Pup.should_receive(:find_by_id).with('1').and_return(temp_pup)
      temp_pup.should_receive(:update_breeder).and_return("")
      temp_pup.should_receive(:update_attributes).with({})
      Breed.should_receive(:find_by_name).with(nil).and_return(temp_breed)
      temp_pup.should_receive(:update_comment).with(nil)

      put :update, {:id => 1, :pup => {}}
      expect(flash[:notice]).to end_with "has been updated"
      response.should redirect_to user_pups_path
    end

    it "should redirect to edit page if breeder not existing" do
      put :update, {:id => 1, :breeder_str => 'invalid'}
      expect(flash[:modal]).to eq "Non existing breeder."
      expect(response).to redirect_to edit_pup_path
    end

  end

  describe "deleting a pup rating" do
    before :each do
      @user1 = FactoryGirl.create(:user)
      sign_in :user, @user1
      @dog1 = FactoryGirl.create(:pup, :user_id => @user1.id)
    end

    it "should find the pup and destroy it's review" do
      temp_pup = Pup.new()
      temp_pup.user_id = @user1.id
      Pup.should_receive(:find_by_id).with('1').and_return(temp_pup)
      temp_pup.should_receive(:destroy)
      delete :destroy, :id => 1

      expect(flash[:notice]).to end_with 'has been deleted'
      response.should redirect_to user_pups_path
    end

    it "should not destroy the dog if pup doesn't exist" do
      expect {
        delete :destroy, :id => 2
      }.to_not change(Pup, :count)
      expect(flash[:notice]).to_not be_empty
      response.should redirect_to user_pups_path
    end

    it "should not delete the dog if user is not the owner" do
      user2 = FactoryGirl.create(:user, :email => "test@test.com")
      sign_in :user, user2
      expect {
        delete :destroy, :id => @dog1.id
      }.to_not change(Pup, :count)
      expect(flash[:notice]).to_not be_empty
      response.should redirect_to user_pups_path
    end
  end
  describe "searching a dog by breed" do
    it "should find dogs with the single breed submitted" do
      fake_dogs = [double('pup1'), double('pup2'), double('pup3')]
      FactoryGirl.create(:breed, :name => "Chinese Shar-Pei")
      Pup.should_receive(:find_by_breed).with("Chinese Shar-Pei").and_return(fake_dogs)
      avg_ratings = {
        'breeder_responsibility'=> 1,
        'overall_health' => 1,
        'trainability' => 1,
        'social_behavior' => 1,
        'energy_level' => 1,
        'simpatico_rating' => 1
      }
      Pup.should_receive(:avg_ratings_by_breeds).with("Chinese Shar-Pei").and_return(avg_ratings)
      get :breed, {:breed => {:name => "Chinese Shar-Pei"}}
      assert true
    end
    it "should redirect to the main page when there are no results" do
      Pup.stub(:find_by_breeds).with('shiba inu', 'None').and_return([])
      Pup.should_receive(:avg_ratings_by_breeds).never
      get :breed, {:breed => {:name => 'shiba inu'}}
      response.should redirect_to root_path
    end
  end

  describe 'find breed by substr for auto-fill' do
    it 'should call the Breed#find_breed_by_substr' do
      expect(Breed).to receive(:find_breed_by_substr).with("breed")
      get :search_breed, {:name => "breed"}
    end

    it 'should return json for Breed' do

      breed1 = FactoryGirl.create(:breed, :name => 'breed1')
      breed2 = FactoryGirl.create(:breed, :name => 'breed2')
      breed3 = FactoryGirl.create(:breed, :name => 'breed3')
      breed4 = FactoryGirl.create(:breed, :name => 'breed4')
      expect = [breed1.name, breed2.name, breed3.name, breed4.name].to_json

      get :search_breed, {:name => "breed"}
      expect(response.body).to eq(expect)
    end
  end

  describe 'edit pup rating' do
    before :each do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user, :email => 'user2@berkeley.edu')
      sign_in :user, @user1
      @breeder1 = FactoryGirl.create(:breeder)
      @breeder2 = FactoryGirl.create(:breeder, :name => "Unknown")
      @dog1 = FactoryGirl.create(:pup, :user_id => @user1.id)
      @dog2 = FactoryGirl.create(:pup, :user_id => @user2.id)
      @dog3 = FactoryGirl.create(:pup, :user_id => @user1.id, :breeder_id => @breeder2.id)
      @breed = FactoryGirl.create(:breed)
    end

    it 'should redirect to home page if pup not existing' do
      get :edit, {:id => 4}
      expect(flash[:notice]).to_not be_empty
      expect(response).to redirect_to root_path
    end

    it 'should redirect to home page if pup not owned' do
      get :edit, {:id => 2}
      expect(flash[:notice]).to_not be_empty
      expect(response).to redirect_to root_path
    end

    it 'should render edit page if everything valid' do
      get :edit, {:id => 1}
      expect(@breed.name).to eq("MyString")
      expect(response).to render_template 'edit'
    end

    it 'should render edit page if everything valid but breeder is unknown' do
      get :edit, {:id => 3}
      expect(@breed.name).to eq("MyString")
      expect(response).to render_template 'edit'
    end
  end

  describe 'displaying correct hashtags' do
    before :each do
      @user1 = FactoryGirl.create(:user)
      sign_in :user, @user1
      @dog1 = FactoryGirl.create(:pup, :user_id => @user1.id)
    end

    it 'should render correct jsons if pup existing' do
      get :hashtags, {:pup_id => @dog1.id}
      expect = [@dog1.hashtag_1, @dog1.hashtag_2, @dog1.hashtag_3].to_json
      expect(response.body).to eq(expect)
    end
  end

  describe 'displaying correct ratings' do
    before :each do
      @user1 = FactoryGirl.create(:user)
      sign_in :user, @user1
      @dog1 = FactoryGirl.create(:pup, :user_id => @user1.id)
    end

    it 'should render correct jsons if pup existing' do
      get :ratings, {:pup_id => @dog1.id}
      pup = @dog1
      ratings_hash = {:breeder => pup.breeder_responsibility, :health => pup.overall_health, :train => pup.trainability,
                      :social => pup.social_behavior, :behavior => pup.dog_behavior, :energy => pup.energy_level,
                      :simpatico => pup.simpatico_rating
                     }
      expect = ratings_hash.to_json
      expect(response.body).to eq(expect)
    end
  end

  it 'should set username correctly when logging in' do
      @user1 = FactoryGirl.create(:user, :username => 'Jeff')
      sign_in :user, @user1
      get :main
      expect(response).to render_template 'main'
  end

  describe 'displaying a random comment' do
    it 'should find a random comment' do
      expect(SelectedComment).to receive(:find_randomly)
      get :random_comment
    end

    it 'should return a json random comment' do
      expect = FactoryGirl.create(:selected_comment).to_json
      get :random_comment
      expect(response.body).to eq(expect)
    end
  end

  describe 'displaying a breed average rating' do
    before :each do
      @user1 = FactoryGirl.create(:user)
      sign_in :user, @user1
      @dog1 = FactoryGirl.create(:pup, :user_id => @user1.id)
      @breed = FactoryGirl.create(:breed)
    end

    it 'should find the average rating' do
      expect(Pup).to receive(:avg_ratings_by_breeds).with(@dog1.breed.name)
      expect(Pup).to receive(:find_by_id).with("#{@dog1.id}").and_return(@dog1)
      get :breed_avg_ratings, {:pup_id => @dog1.id}
    end

    it 'should return a json avg rating' do
      expect = Pup.avg_ratings_by_breeds(@breed.name).to_json
      get :breed_avg_ratings, {:pup_id => @dog1.id}
      expect(response.body).to eq(expect)
    end
  end
end
