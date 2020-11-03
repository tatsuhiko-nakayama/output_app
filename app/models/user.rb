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

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数のみで両方含めてください'
end
