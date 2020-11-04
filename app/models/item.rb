class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_many :likes
  has_many :comments
  has_many :item_tags
  has_many :tags, through: :item_tags
  belongs_to_active_hash :category

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :body, length: { maximum: 100000 }
    validates :category_id
  end
  validates :tagbody, length: { maximum: 30 }
end