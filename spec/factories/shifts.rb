FactoryGirl.define do
  factory :shift do
    team
    user
    job
    start { DateTime.now.beginning_of_hour }
    stop  { 5.hours.from_now.beginning_of_hour }
  end
end
