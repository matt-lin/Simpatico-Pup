class Feedback < ActiveRecord::Base
  attr_accessible :open_response, :rate_dog, :breed_rating, :breeder_rating, :forum, :search_breeder
end
