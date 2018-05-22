FactoryGirl.define do
  factory :timeline do
    title 'Прибрав вулицю'
    date '2016-07-26 21:00:00'
    description Faker::Lorem.paragraphs
    initiative_id 1
  end
end
