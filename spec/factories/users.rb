FactoryBot.define do
  factory :user do
    username { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    password { 'test1234' }
    password_confirmation { password }
  end
end
