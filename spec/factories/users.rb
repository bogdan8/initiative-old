FactoryGirl.define do
  factory :user, class: User do
    name 'Bogdan'
    post '123456'
    phone '123456'
    email Faker::Internet.email
    password '123456'
    avatar { File.open('spec/support/photo.jpg') }
    confirmed_at '2016-07-17 07:35:55.139051'
    confirmation_sent_at '2016-07-17 07:35:36.292019'
  end
end
