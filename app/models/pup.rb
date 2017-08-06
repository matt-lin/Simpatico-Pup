class Pup < ActiveRecord::Base
  is_impressionable :counter_cache => true
  #Iter3-2 include strong params to deal with mass assignment issue (By Gung Hiu Ho)
  #include ActiveModel::ForbiddenAttributesProtection
  
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
      result = []
    else
      result = Pup.where("breed_id = ?", Breed.find_by_name( breed_name ).id).order("created_at DESC")
    end
    result
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
      results_hash.each do |rating, _value|
        unless pup.send(rating) == nil
          results_hash[rating] += pup.send(rating)
          results_num[rating] += 1
        end
        # results_hash[rating] += pup.send(rating)
      end
      count += 1.0
    end
    results_hash.each do |k, _v|
      results_hash[k] = 1.0 * results_hash[k]/results_num[k] if results_num[k] > 0
      # results_hash[k] /= count
    end
    results_hash
  end
  
  #Check whether a breed is legal one
  def Pup.legal_dog(breed_name)
    not Breed.find_by_name(breed_name) == nil
  end
  
  # Iter3-2 (Gilbert Lo, Jeff Yu)
  def update_comment(content)
    if self.comment
      self.comment.content = content
      self.comment.save
    else
      self.create_comment(:content => content)
    end
  end
  
  def update_breeder(breeder_str)
    if breeder_str.empty?
      self.breeder = Breeder.where('name = ?', 'Unknown').first
      return self.breeder
    end
    
    breeder = Breeder.find_by_formatted_string(breeder_str)
    if breeder
      self.breeder = breeder
    else
      # New Breeder
      nil
    end
  end
  
  def Pup.build_pup(params_hash, session_hash, user_id)
    new_pup = {}
    new_pup[:pup_name] = session_hash[:pup_name]
    new_pup[:year] = session_hash[:years] || 0
    new_pup[:month] = session_hash[:months] || 0
    new_pup[:breeder_responsibility] = params_hash[:pup][:breeder_responsibility]
    new_pup[:overall_health] = params_hash[:pup][:overall_health]
    new_pup[:trainability] = params_hash[:pup][:trainability]
    new_pup[:social_behavior] = params_hash[:pup][:social_behavior]
    new_pup[:dog_behavior] = params_hash[:pup][:dog_behavior]
    new_pup[:energy_level] = params_hash[:pup][:energy_level]
    new_pup[:simpatico_rating] = params_hash[:pup][:simpatico_rating]
    new_pup[:hashtag_1] = params_hash[:pup][:hashtag_1]
    new_pup[:hashtag_2] = params_hash[:pup][:hashtag_2]
    new_pup[:hashtag_3] = params_hash[:pup][:hashtag_3]
    new_pup[:breed_id] = Breed.find_by_name(session_hash[:breed]).id
    new_pup[:breeder_id] = session_hash[:breeder_id]
    new_pup[:user_id] = user_id
    new_pup[:breed_1] = session_hash[:breed]
    return Pup.new(new_pup)
  end
  
  def hashtags
    [self.hashtag_1, self.hashtag_2, self.hashtag_3]
  end
  
  def ratings
    {:breeder => self.breeder_responsibility, :health => self.overall_health, :train => self.trainability,
     :social => self.social_behavior, :behavior => self.dog_behavior, :energy => self.energy_level,
     :simpatico => self.simpatico_rating 
    }
  end
  
  # End Iter3-2
  
  private
  def limit_ratings
    # if self.user.pups(:reload).size > 8
    #   errors.add(:base, "SimpaticoPup is a website designed to collect information from dog lovers about their own companion dogs. To ensure that our rating summaries accurately reflect input from a wide variety of dog owners, we are currently limiting the number of ratings made by each dog owner to eight, and limiting each dog owner to rating only two dogs that come from the same dog breeder. Thank you for your contributions to our database.")
    # end
  end

end
