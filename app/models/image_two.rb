class ImageTwo < ApplicationRecord
  belongs_to :project
  has_many :images, as: :imageable
end
