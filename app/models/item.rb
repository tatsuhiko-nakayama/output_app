class Item < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments
  has_many :item_tags
  has_many :tags, through: :item_tags
  belongs_to_active_hash :category

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :body, length: { maximum: 100000 }
  end
  validates :tagbody, length: { maximum: 60 }
  validates :category_id, numericality: { other_than: 1, message: 'を選んでください' }
end
