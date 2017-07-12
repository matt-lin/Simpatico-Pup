class Pup < ActiveRecord::Base

  belongs_to :user
  # validate :limit_ratings
  belongs_to :breeder
  belongs_to :breed

  has_one :comment, dependent: :destroy

  validates :pup_name, :presence => true
  # validates :user_id, :presence => true
  validates :breeder_id, :presence => true
  
  ######breed_id may not be needed, result table creation error in admin.feature
  validates :breed_id, :presence => false 
  ####################################
  
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
    # breed_id = Breed.find_by_name(breed_name)
    # result = Pup.where("breed_1 = ?", breed_name).order("created_at DESC")
    # result += Pup.where("breed_2 = ?", breed_name).order("created_at DESC")
    if Breed.find_by_name(breed_name).nil?
      []
    else
      result = Pup.where("breed_id = ?", Breed.find_by_name( breed_name ).id).order("created_at DESC")
    end
  end
  
  def Pup.find_by_breeds(breed1, breed2='None')
      # result = Pup.where("breed_1 = ? and breed_2 = ?", breed1, breed2).order("created_at DESC")
      # result += Pup.where("breed_1 = ? and breed_2 = ?", breed2, breed1).order("created_at DESC")
    if Breed.is_valid_breed breed1
      result = Pup.where("breed_id = ?", Breed.find_by_name( breed1 ).id)
      if breed2 != 'None'
        result = Pup.where("breed_id = ?", Breed.find_by_name( breed2 ).id)
      end
      result.order("created_at DESC")
    else
      []
    end
    
  end

  def Pup.avg_ratings_by_breeds(breed1, breed2='None')
    pups_by_breed = Pup.find_by_breeds(breed1, breed2)
    results_hash = {:overall_health => 0, :trainability => 0, :social_behavior => 0,
                    :dog_behavior => 0, :energy_level => 0, :simpatico_rating => 0}
    results_num = {:overall_health => 0, :trainability => 0, :social_behavior => 0,
                   :dog_behavior => 0, :energy_level => 0, :simpatico_rating => 0}
    count = 0.0
    pups_by_breed.each do |pup|
      results_hash.each do |rating, value|
        unless pup.send(rating) == nil
          results_hash[rating] += pup.send(rating)
          results_num[rating] += 1
        end
        # results_hash[rating] += pup.send(rating)
      end
      count += 1.0
    end
    results_hash.each do |k,v|
      results_hash[k] = 1.0 * results_hash[k]/results_num[k] if results_num[k] > 0
      # results_hash[k] /= count
    end
    results_hash
  end
  
  #Check whether a breed is legal one
  def Pup.legal_dog(breed_name)
    not Breed.find_by_name(breed_name) == nil
  end
  
  
  private
  def limit_ratings
    # if self.user.pups(:reload).size > 8
    #   errors.add(:base, "SimpaticoPup is a website designed to collect information from dog lovers about their own companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety of dog owners, we are currently limiting the number of ratings made by each dog owner to eight, and limiting each dog owner to rating only two dogs that come from the same dog breeder. Thank you for your contributions to our database.")
    # end
  end

end
