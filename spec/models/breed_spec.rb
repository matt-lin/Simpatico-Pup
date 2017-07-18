require 'spec_helper'

describe Breed do
    before :each do
        @affenpinscher = FactoryGirl.create(:breed, :name => 'Affenpinscher')
        @shar_pei = FactoryGirl.create(:breed, :name => 'Chinese Shar-Pei')
        @keeshond = FactoryGirl.create(:breed, :name => 'Keeshond')
        @saluki = FactoryGirl.create(:breed, :name => 'Saluki')
        @crested = FactoryGirl.create(:breed, :name => 'Chinese Crested')
        @whippet = FactoryGirl.create(:breed, :name => 'Whippet')
    end
    
    describe 'is_valid_breed' do
        it 'return false for not valid breed' do
            expect(Breed.is_valid_breed("random breed")).to eq false
            expect(Breed.is_valid_breed("fake breed")).to eq false
        end
        it 'return true for valid breed' do
            expect(Breed.is_valid_breed("Saluki")).to eq true
            expect(Breed.is_valid_breed("Affenpinscher")).to eq true
        end
    end
    
    describe 'find_breed_by_substr' do
        it 'return nothing for not matching breed' do
            expect(Breed.find_breed_by_substr("ka")).to eq []
            expect(Breed.find_breed_by_substr("doggy")).to eq []
        end
        it 'return match breed' do
            expect(Breed.find_breed_by_substr("Saluki")).to eq [@saluki.name]
            expect(Breed.find_breed_by_substr("chinese")).to eq [@shar_pei.name, @crested.name]
        end
    end
    
    describe 'find_by_name' do
        it 'return nil for not matching breed' do
            expect(Breed.find_by_name("random breed")).to eq nil
            expect(Breed.find_by_name("fake breed")).to eq nil
        end
        it 'return match breed' do
            expect(Breed.find_by_name("Keeshond")).to eq @keeshond
            expect(Breed.find_by_name("Whippet")).to eq @whippet
        end
    end
    
    describe 'all_breeds' do
        it 'return all breed as array' do
            result = [@affenpinscher.name, @shar_pei.name, @keeshond.name, 
                    @saluki.name, @crested.name, @whippet.name]
            expect(Breed.all_breeds).to eq result
        end
    end
end
