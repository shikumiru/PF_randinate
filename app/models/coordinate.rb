class Coordinate < ApplicationRecord
  belongs_to :user

  enum style: { mens: 0, ladies: 1, unisex: 2 }

  has_one_attached :coordinate_image

  # gem:acts_as_taggableの使用
  acts_as_taggable_on :tags
end
