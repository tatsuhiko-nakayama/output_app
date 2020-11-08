class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :message, presence: true, length: { maximum: 10_000 }
end
