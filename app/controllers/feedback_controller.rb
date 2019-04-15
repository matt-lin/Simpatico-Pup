class FeedbackController < ApplicationController

  def new
    # Auto renders 'new' template
  end

  def create
    if !params.has_key?('feedback')
      redirect_to feedback_path and return
    end
    open_resp = params[:feedback][:open_response]
    rate_dog = params[:feedback][:rate_dog]
    breed_rating = params[:feedback][:breed_rating]
    breeder_rating = params[:feedback][:breeder_rating]
    forum = params[:feedback][:forum]

    # All scale ratings mandatory
    if rate_dog.empty? || breed_rating.empty? || breeder_rating.empty? || forum.empty?
      flash[:notice] = "Please complete the form."
      redirect_to feedback_path and return
    end

    @feedback = Feedback.new(params[:feedback])

    if @feedback.save
      flash[:message] = "Thanks for your feedback!"
      redirect_to feedback_path, alert: "Feedback submitted successfully."
    else
      flash[:message] = "Oops, something went wrong!"
      redirect_to feedback_path, alert: "Error submitting feedback."
    end
  end

end
