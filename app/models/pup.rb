class Pup < ActiveRecord::Base

  belongs_to :user
  validate :limit_ratings
  belongs_to :breeder
  belongs_to :breed

  has_one :comment, dependent: :destroy

  validates :pup_name, :presence => true
  # validates :user_id, :presence => true
  validates :breeder_id, :presence => true
  validates :breed_id, :presence => true
  validates :breeder_responsibility, :presence => true
  validates :overall_health, :presence => true
  validates :trainability, :presence => true
  validates :social_behavior, :presence => true
  validates :energy_level, :presence => true
  validates :simpatico_rating, :presence => true

  attr_accessible :pup_name, :year, :month, :user_id, :breeder_id, :breed_id, :breeder_responsibility, :overall_health,
                  :trainability, :social_behavior,:dog_behavior, :energy_level, :simpatico_rating, :kennel,
                  :hashtag_1, :hashtag_2, :hashtag_3


  # Info - Commented by Mallow-Tech developer and same logic implemented in dogs controller
  # before_destroy { |pup| pup.breeder ? pup.breeder.increment_deleted_reviews : nil }



  # assets

  def safe_hashtag_string
    [hashtag_1, hashtag_2, hashtag_3].select{|hashtag| hashtag}
  end



  # class methods
  def Pup.find_by_breed(breed_name)
    breed_id = Breed.find_by_name(breed_name)
    Pup.where("breed_id = ?", breed_id).order("created_at DESC")
  end

  def Pup.avg_ratings_by_breed(breed_name)
    pups_by_breed = Pup.find_by_breed(breed_name)
    results_hash = {:overall_health => 0, :trainability => 0, :social_behavior => 0,
                    :dog_behavior => 0, :energy_level => 0, :simpatico_rating => 0}
    results_num = {:overall_health => 0, :trainability => 0, :social_behavior => 0,
                   :dog_behavior => 0, :energy_level => 0, :simpatico_rating => 0}
    pups_by_breed.each do |pup|
      results_hash.each do |rating, value|
        unless pup.send(rating) == 0
          results_hash[rating] += pup.send(rating)
          results_num[rating] += 1
        end
      end
    end
    results_hash.each do |k,v|
      results_hash[k] = 1.0 * results_hash[k]/results_num[k] if results_num[k] > 0
    end
    results_hash
  end

  private
  def limit_ratings
    if self.user.pups(:reload).size > 8
      errors.add(:base, "SimpaticoPup is a website designed to collect information from dog lovers about their own companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety of dog owners, we are currently limiting the number of ratings made by each dog owner to eight, and limiting each dog owner to rating only two dogs that come from the same dog breeder. Thank you for your contributions to our database.")
    end
  end

end
