class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :coordinates, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true, length: { in: 2..10 }
  validates :gender, presence: true

  enum gender: { male: 0, female: 1, other: 2 }

  # ゲストユーザーログイン機能
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.gender = "other"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
