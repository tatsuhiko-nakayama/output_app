class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_items, through: :likes, source: :item
  has_many :relationships, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 14 }

  USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/.freeze
  validates_format_of :username, with: USERNAME_REGEX, message: 'は半角英数で入力してください'
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数のみで両方含めてください'

  def already_liked?(item)
    likes.exists?(item_id: item.id)
  end
  
end
