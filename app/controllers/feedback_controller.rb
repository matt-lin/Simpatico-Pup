class FeedbackController < ApplicationController

  def index

  end

  def show

  end

  def new
    # Auto renders 'new' template
  end

  def create
    puts(params)
    open_resp = params[:feedback][:open_response]
    rate_dog = params[:feedback][:usability_rateyourdog]
    breed_rating = params[:feedback][:usability_findratingbreed]
    breeder_rating = params[:feedback][:usability_findratingbreeder]
    search_breeder = params[:feedback][:usability_searchbreeder]
    forum = params[:feedback][:usability_forum]

    # All scale ratings mandatory
    if check_params([rate_dog, breed_rating, breeder_rating, search_breeder, forum]) == false
      flash[:notice] = "Please complete the form."
      redirect_to feedback_path and return
    end

    @feedback = Feedback.create!(:open_response => open_resp, :rate_dog => rate_dog, :breed_rating => breed_rating, :breeder_rating => breeder_rating, :search_breeder => search_breeder, :forum => forum)

    if @feedback.save
      flash[:notice] = "Thanks for your feedback!"
      redirect_to thanks_feedback_path
    else
      flash[:notice] = "Oops, something went wrong!"
      redirect_to feedback_path
    end
  end

  def check_params(list_of_params)
    for param in list_of_params
      if param == "N/A"
        return false
      end
    end
    return true
  end

  def check_request_params(params)
    if params.has_key?('feedback')
      return true
    end
    return false
  end

  def thanks

  end

end
