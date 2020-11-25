class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '本' },
    { id: 2, name: 'Youtube' },
    { id: 3, name: '記事/SNS' },
    { id: 4, name: 'イベント' },
    { id: 5, name: 'メモ' }
  ]
end
