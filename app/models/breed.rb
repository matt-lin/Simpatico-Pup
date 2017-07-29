class Breed < ActiveRecord::Base
  has_many :pups
  attr_accessible :name


  def Breed.is_valid_breed(breed)
    Breed.all_breeds.include? breed
    # !Breed.where(name: breed).empty?
  end

  def Breed.find_breed_by_substr(s)
    Breed.all_breeds.select { |b| b.downcase.include? s.downcase }
  end

  def Breed.find_by_name(breed_name)
    result = Breed.where("name = ?", breed_name).first
    # Added on 7/15/17
    if !result
      return nil
    end
    return result
  end

  #private
  def Breed.all_breeds
    return Breed.select('name').map{ |e| e.name }.to_a
  end
end
