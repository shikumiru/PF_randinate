class Coordinate < ApplicationRecord
  belongs_to :user

  enum style: { mens: 0, ladies: 1, unisex: 2 }

  has_one_attached :coordinate_image

  def get_coordinate_image(width, height)
    coordinate_image.variant(resize_to_limit: [width, height]).processed
  end

  # gem:acts_as_taggableの使用
  acts_as_taggable_on :tags

  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end
end
