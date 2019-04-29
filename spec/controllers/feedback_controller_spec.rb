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
