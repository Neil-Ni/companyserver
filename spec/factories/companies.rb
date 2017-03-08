FactoryGirl.define do
  factory :company do
    name   { Faker::Name.first_name }
  end
end
