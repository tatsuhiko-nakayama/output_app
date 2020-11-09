class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user
  has_many :item_tags
  has_many :tags, through: :item_tags
  belongs_to_active_hash :category

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :body, length: { maximum: 100_000 }
    validates :category_id
  end
  validates :tagbody, length: { maximum: 60 }

  after_create do
    item = Item.find_by(id: id)
    tags = tagbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      t = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      item.tags << t
    end
  end

  before_update do
    item = Item.find_by(id: id)
    item.tags.clear
    tags = tagbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      t = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      item.tags << t
    end
  end

  def self.search(search)
    if search != ""
      Item.where('title LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end


end
