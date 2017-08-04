class Breed < ActiveRecord::Base
  has_many :pups
  attr_accessible :name


  def Breed.is_valid_breed(breed)
    Breed.all_breeds.include? breed
    # !Breed.where(name: breed).empty?
  end

  def Breed.find_breed_by_substr(s)
    Breed.all_breeds.select { |b| (Breed.contain? b.downcase, s.downcase) }
  end

  def Breed.find_by_name(breed_name)
    result = Breed.where("name = ?", breed_name).first
    # Added on 7/15/17
    if !result
      return nil
    end
    return result
  end
  
  def Breed.contain?(name, str)
    #name.gsub!(/\W+/, '')
    flag = false
    name.split(" ").each do |sub|
      flag = true if sub.starts_with? str
    end
    return flag
  end

  #private
  def Breed.all_breeds
    return Breed.select('name').map{ |e| e.name }.to_a
  end

end
