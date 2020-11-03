class Category < ActiveHash::Base
  self.data = [
    { id:1, name: '本'},
    { id:2, name: 'Youtube'},
    { id:3, name: '記事'},
    { id:4, name: 'SNS'},
    { id:5, name: 'イベント'},
    { id:6, name: '映画'},
    { id:7, name: '出来事'}
  ]
end