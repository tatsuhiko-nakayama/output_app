class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :lastname, :firstname, length: { maximum: 20 }
  validates :intro, length: { maximum: 80 }
end
