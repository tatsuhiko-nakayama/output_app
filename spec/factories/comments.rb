FactoryBot.define do
  factory :comment do
    message { 'サンプルメッセージです' }
    association :user
    association :item
  end
end
