class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images
  accepts_nested_attributes_for :product_images
  enum status: %i( --- 新品 未使用に近い 目立った傷や汚れなし やや傷や汚れあり 傷や汚れあり 全体的に状態が悪い )
end
