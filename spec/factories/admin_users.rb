FactoryGirl.define do
  factory :admin_user do
    email "admin@berkeley.edu"
    password 'password'
    password_confirmation 'password'
  end

end
