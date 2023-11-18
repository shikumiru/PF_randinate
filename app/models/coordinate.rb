class Coordinate < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :actions, dependent: :destroy

  validates :coordinate_image, presence: true
  validates :style, presence: true
  validates :introduction, length: { maximum: 180 }

  enum style: { mens: 0, ladies: 1, unisex: 2 }

  # active_storage
  has_one_attached :coordinate_image

  def get_coordinate_image(width, height)
    coordinate_image.variant(resize_to_limit: [width, height]).processed
  end

  # gem:acts_as_taggable
  acts_as_taggable_on :tags

  # ブックマーク
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  # 公開・非公開のスコープ
  scope :published, -> { where(is_published: true) }
  scope :draft, -> { where(is_published: false) }
end
