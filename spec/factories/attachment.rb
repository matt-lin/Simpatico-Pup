FactoryGirl.define do
  factory :attachment do
    document { File.new("#{Rails.root}/spec/support/fixtures/a.txt") }
  end
end
