FactoryGirl.define do
  factory :feedback do
    open_response "MyText"
    rate_dog 1
    breed_rating 1
    breeder_rating 1
    forum 1
  end
end
