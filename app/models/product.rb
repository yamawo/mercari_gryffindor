class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand, optional: true
  has_many :product_images
  accepts_nested_attributes_for :product_images, allow_destroy: true
end
