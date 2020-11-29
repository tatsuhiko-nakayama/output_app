class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :notifications, dependent: :destroy

  validates :message, presence: true, length: { maximum: 10_000 }
end
