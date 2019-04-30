require 'spec_helper'

describe FeedbackController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  # describe "POST 'create'" do
  #   it "returns http success" do
  #     post :create, params: {
  #       feedback: {
  #         usability_rateyourdog: "1",
  #         usability_findratingbreed: "2",
  #         usability_findratingbreeder: "3",
  #         usability_searchbreeder: "3",
  #         usability_forum: "3",
  #         open_response: "test"
  #       }
  #     }
  #     response.should be_success
  #   end
  # end

  describe "check_request_params" do
    before :each do
      @params1 = {
        'feedback' => 'stuff here'
      }
      @params2 = {
        'random' => 'no feedback'
      }
    end

    it 'returns false if params does not have feedback key' do
      expect(FeedbackController.check_request_params(@params2)).to eq false
    end

    it 'returns true if params does contain feedback key' do
      expect(FeedbackController.check_request_params(@params1)).to eq true
    end
  end

  describe "check_params" do
    before :each do
      @list_of_params1 = ['test', 1, 2, 3, 4, 5]
      @list_of_params2 = ['tester', 1, 2, 3, 4, 'N/A']
    end

    it 'returns true if valid params' do
      expect(FeedbackController.check_params(@list_of_params1)).to eq true
    end

    it 'returns false if invalid params' do
      expect(FeedbackController.check_params(@list_of_params2)).to eq false
    end
  end

  describe "submitting feedback without correct paramters" do
    it "calling with open response should redirect to feedback_path" do
      post :create, { :feedback => { :open_response => "hello" }}
      puts (response)
      expect(response).to redirect_to thanks_feedback_path
    end

    it "calling with only 1 rating should redirect to feedback_path" do
      post :create, { :feedback => { :breeder_rating => 1 }}
      expect(response).to redirect_to thanks_feedback_path
    end
  end

  describe "submitting feedback with proper paramters" do
    it "calling with all valid params should redirect to thanks_feedback_path" do
      post :create, { :feedback => { :open_resp => "oops", :rate_dog => 1, :breed_rating => 1, :breeder_rating => 1, :search_breeder => 1, :forum => 1}}
      expect(response).to redirect_to thanks_feedback_path
    end
  end

  describe "GET 'thanks'" do
    it "returns http success" do
      get 'thanks'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
