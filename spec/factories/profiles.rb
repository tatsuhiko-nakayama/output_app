FactoryBot.define do
  factory :profile do
    lastname { 'test' }
    firstname { 'test' }
    website { 'https://test.com' }
    intro { '自己紹介文です' }
    association :user

    after(:build) do |i|
      i.image.attach(io: File.open('public/images/human_icon.png'), filename: 'human_icon.png')
    end
  end
end
