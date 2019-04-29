class Feedback < ActiveRecord::Base
  attr_accessible :open_response, :rate_dog, :breed_rating, :breeder_rating, :forum, :search_breeder

  #private
  def Feedback.all_feedbacks
    return Feedback.select('open_response').map{ |e| e.open_response }.to_a
  end

  def Feedback.is_valid_feedback(feedback)
    Feedback.all_feedbacks.include? feedback
  end

  def Feedback.find_by_score(field, score)
    query = field + " = ?"
    result = Feedback.where(query, score).first

    if !result
      return nil
    end
    return result
  end


end
