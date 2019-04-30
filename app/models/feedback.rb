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
    query_dictionary = {
      'dog_rating' => 'rate_dog = ?',
      'breed_rating' => 'breed_rating = ?',
      'breeder_rating' => 'breeder_rating = ?',
      'forum_rating' => 'forum = ?'
    }
    if query_dictionary[field] == nil
      raise 'Invalid field in query: ' + field
    end
    result = Feedback.where(query_dictionary[field], score).first

    if !result
      return nil
    end
    return result
  end


end
