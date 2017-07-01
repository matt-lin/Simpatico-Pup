FactoryGirl.define do
  factory :pup do
    pup_name 'Doge'
    owner_name 'Curious George'
    association :breeder, factory: :breeder
    breed_1 'shiba inu'
    breed_2 'None'
    breeder_responsibility 1
    overall_health 1
    trainability 1
    social_behavior 1
    energy_level 1
    simpatico_rating 1
    comments "Wow. Such doge. Very pup."
    breed_id 1
    breeder_id 1
  end
end