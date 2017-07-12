FactoryGirl.define do
  factory :user do
    email "lolright@aol.com"
    password "lolright"
    password_confirmation "lolright"
    remember_me true
  end

end
