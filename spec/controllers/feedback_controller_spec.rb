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

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
