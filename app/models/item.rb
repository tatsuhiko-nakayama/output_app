class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  belongs_to_active_hash :category
  has_one_attached :image
  has_many :notifications, dependent: :destroy

  enum status: { closed: 0, open: 1 }
  paginates_per 10

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :body, length: { maximum: 100_000 }
    validates :category_id
  end
  validates :tagbody, length: { maximum: 60 }
  validates :tagbody, format: { without: /[０-９]/, message: 'の数字は半角で入力してください' }
  validates :tagbody, format: { without: /＃/, message: ' # は半角で入力してください' }
  validates :tagbody, format: { without: /♯/, message: ' # は半角で入力してください' }

  after_create do
    item = Item.find_by(id: id)
    tags = tagbody.scan(/#[\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      t = Tag.find_or_create_by(name: tag.delete('#'))
      item.tags << t
    end
  end

  before_update do
    item = Item.find_by(id: id)
    item.tags.clear
    tags = tagbody.scan(/#[\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |tag|
      t = Tag.find_or_create_by(name: tag.delete('#'))
      item.tags << t
    end
  end

  def self.search(search)
    if search != ''
      Item.where('title LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

  def create_notification_like(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and item_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        item_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(item_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      item_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
