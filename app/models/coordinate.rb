class Coordinate < ApplicationRecord
  belongs_to :user

  validates :style, presence: true
  validates :introduction, length: { maximum: 180 }

  enum style: { mens: 0, ladies: 1, unisex: 2 }

  # active_storageの使用
  has_one_attached :coordinate_image

  def get_coordinate_image(width, height)
    unless coordinate_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      coordinate_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    coordinate_image.variant(resize_to_limit: [width, height]).processed
  end

  # gem:acts_as_taggableの使用
  acts_as_taggable_on :tags

  # いいね機能
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  # 公開・非公開のスコープ
  scope :published, -> { where(is_published: true) }
  scope :draft, -> { where(is_published: false) }
end
