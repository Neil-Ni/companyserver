FactoryGirl.define do
  factory :job do
    name   { Faker::Name.first_name }
  end
end
