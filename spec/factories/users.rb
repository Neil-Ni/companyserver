FactoryGirl.define do
  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    phonenumber  { Faker::PhoneNumber.cell_phone }
    email         { Faker::Internet.email }
    password      { Faker::Internet.password(8) }
    company
  end
end
