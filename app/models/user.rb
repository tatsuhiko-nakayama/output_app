class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :items
  has_many :comments
  has_many :likes
  has_many :relationships, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: true}

end
