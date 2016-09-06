class Breeder < ActiveRecord::Base
  has_many :pups
  attr_accessible :name, :city, :state, :website, :removed_reviews

  before_destroy { |breeder| breeder.dismentle_pups }

  geocoded_by :address
  after_validation :geocode

  def address
    if self.city and self.state
      self.city + ', ' + self.state
    else
      ""
    end
  end

  def all_pups
    pups.order("created_at DESC")
  end

  def avg_pup_rating
    results_hash = {:overall_health => 0, :trainability => 0, :social_behavior => 0, :dog_behavior => 0,
                    :energy_level => 0, :simpatico_rating => 0, :breeder_responsibility => 0}
    results_num = {:overall_health => 0, :trainability => 0, :social_behavior => 0, :dog_behavior => 0,
                   :energy_level => 0, :simpatico_rating => 0, :breeder_responsibility => 0}
    all_pups.each do |pup|
      results_hash.each do |rating, v|
        unless pup.send(rating) == 0
          results_hash[rating] += pup.send(rating)
          results_num[rating] += 1
        end
      end
    end
    results_hash.each do |k,v|
      results_hash[k] = 1.0 * results_hash[k]/results_num[k] if results_num[k] > 0
    end
  end

  def dismentle_pups
    pups.each do |p|
      p.breeder_id = 1
      p.save!
    end
  end

  # Info - Commented by Mallow-Tech developer and same logic implemented in dogs controller
  # def increment_deleted_reviews
  #   update_attributes(:removed_reviews => removed_reviews + 1)
  #   save!
  # end

  def Breeder.find_by_substring(name, limit = 0)
    breeders = Breeder.skip_one
    query_str ="name LIKE ? OR name LIKE ?"
    if name.length >= 1
      name = name[0].upcase + name[1..-1]
    end
    query_values = ["#{name}%"] + ["% #{name}%"]
    limit == 0 ? breeders.where(query_str, *query_values) : breeders.where(query_str, *query_values).limit(limit)
  end
  
  def Breeder.is_valid_breeder(name)
    breeders = Breeder.skip_one
    breeders = breeders.where("name = ?", name)
    return breeders.any?
  end
  
  def Breeder.find_by_formatted_string(search_str)
    m = /^([a-zA-Z ]+) - ([a-zA-Z ]+), ([a-zA-Z ]+)$/.match(search_str)
    if m
      breeders = Breeder.skip_one
      breeders.where("name = ? AND city = ? AND state = ?", m[1], m[2], m[3]).first
    end
  end

  private
  def Breeder.skip_one
    Breeder.where("id > 1")
  end

end