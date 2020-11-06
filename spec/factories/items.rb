FactoryBot.define do
  factory :item do
    title { 'タイトル' }
    tagbody { '#hashtag' }
    body { '本文' }
    url { 'https://test' }
    status { '0' }
    category_id { '1' }
    association :user
  end
end
