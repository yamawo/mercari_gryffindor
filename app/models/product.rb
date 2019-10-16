class Product < ApplicationRecord
  belongs_to :user, dependent: :delete
  belongs_to :category
  belongs_to :brand
  has_many :product_images
  has_many :likes
end
