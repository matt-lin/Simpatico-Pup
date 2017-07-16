require 'spec_helper'

describe Breeder do
  describe "getting average rating of a breeder" do
    before :each do
      @breeder = FactoryGirl.create(:breeder)
      pups = 10.times.collect  { |i| FactoryGirl.create(:pup, :breeder_id => @breeder.id)}
      @breeder.pups.should == pups
    end
    it "should get the average ratings for each pup" do
      results_hash = {:overall_health => 1.0, :trainability => 1.0, :social_behavior => 1.0,
                      :dog_behavior => 1.0, :energy_level => 1.0, :simpatico_rating => 1.0, :breeder_responsibility => 1.0}
      @breeder.pups.each do |pup|
        results_hash.each{|k,v| pup.send(k).should == 1.0}
      end
      @breeder.avg_pup_rating.should == results_hash
    end
  end
  
  describe "find all matching breeders" do
    before :each do
      @breeders = (1..10).map { |i| FactoryGirl.create(:breeder) }
      @other_breeders = (1..5).map { |i| FactoryGirl.create(:breeder, :name => "Tedus") }
      @pups = (1..10).map {|i| FactoryGirl.create(:pup, :breeder_id => @breeders[i-1].id)}
    end
    describe "find by city, state, name" do
      it "should find all the breeders input into database" do
        Breeder.find_by_substring("Ted").should == @breeders + @other_breeders
      end
      it "should only return 5 breeders input" do
        breeders = Breeder.find_by_substring("Ted")
        breeders.each do |breeder|
          assert(@breeders.include?(breeder) || @other_breeders.include?(breeder), "Breeder not in those created")
        end
      end
      it "should only find the 'Teddy' breeders" do
        Breeder.find_by_substring("Teddy").each do |breeder|
          assert(@breeders.include?(breeder), "Breeder not in the 'Teddy' breeders array")
        end
      end
      it "should find every breeders with substr T" do
        Breeder.find_by_substring("T").should == @breeders + @other_breeders
      end
    end
    describe "find by type of dog breed" do
      it "should find all breeders" do
        breeders_by_breed = Breeder.find_breeders_by_breed(@pups[0].breed_1, @pups[0].breed_2)
        @breeders.each {|breeder| assert(breeders_by_breed.include?(breeder), "Breeder by breed not found")}
      end
      it "should not find any breeders" do
        breeders_by_breed = Breeder.find_breeders_by_breed("NOT A REAL BREED", "None")
        breeders_by_breed.size.should == 0
      end
    end
    describe "find breeders by city, state, name, and breed" do
      it "should find all initial 10 breeders" do
        query = {
            :city => "Berkeley",
            :state => "CA",
            :name => "Ted",
            :breed_1 => @pups[0].breed_1,
            :breed_2 => @pups[0].breed_2
        }
        breeders_intersect = Breeder.intersect_by_substring_and_breed(query, limit = 5)
        breeders_intersect.each do |breeder|
          assert(@breeders.include?(breeder))
        end
        breeders_intersect.size.should == 5
      end
    end
  end

  describe "increment deleted reviews for breeder" do
    it "should increase by 1" do
      breeder = FactoryGirl.create(:breeder)
      initial = breeder.removed_reviews
      breeder.increment_deleted_reviews
      breeder.removed_reviews.should == (initial + 1)
    end
  end
  describe "validate a breeder" do
    before :each do
      breeder = FactoryGirl.create(:breeder, :name=>"John")
    end
    it "should return true if breeder name is valid" do
      Breeder.is_valid_breeder("John").should be_true
    end
    it "should return false if breeder name is invalid" do
      Breeder.is_valid_breeder("Triss").should be_false
    end
  end
  describe "show a breeder's address" do
    before :each do
      @breeder_with_address = FactoryGirl.create(:breeder, :name=>"John", :city=>"Berkeley", :state=>"CA")
      @breeder_without_address = FactoryGirl.create(:breeder, :name=>"Tiss", :city=>nil, :state=>nil)
    end
    it "shuold show correct address if city and state info exist" do
      @breeder_with_address.address.should eq(@breeder_with_address.city + ", " + @breeder_with_address.state)
    end
    it "shuold show empty string if city and state info not exist" do
      @breeder_without_address.address.should eq("")
    end
  end
  
  describe "find breeder by using formatted string" do
    before :each do
     @breeder_with_address = FactoryGirl.create(:breeder, :name=>"John", :city=>"Berkeley", :state=>"CA")
    end
    Breeder.find_by_formatted_string("(John) - (Berkeley), (CA)").should == @breeder_with_address
  end
  
  describe "dismentle some pups" do
    before :each do
      @breeder = FactoryGirl.create(:breeder)
      pups = 10.times.collect  { |i| FactoryGirl.create(:pup, :breeder_id => @breeder.id)}
    end
    it "should get the average ratings for each pup" do
      results_hash = {:overall_health => 1.0, :trainability => 1.0, :social_behavior => 1.0,
                      :dog_behavior => 1.0, :energy_level => 1.0, :simpatico_rating => 1.0, :breeder_responsibility => 1.0}
      @breeder.pups.each do |pup|
        results_hash.each{|k,v| pup.send(k).should == 1.0}
      end
      @breeder.dismentle_pups
      @breeder.pups.each do |pup|
        pup.breeder_id.should eq 1
      end
    end
  end
end