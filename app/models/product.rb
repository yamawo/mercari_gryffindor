class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images
  accepts_nested_attributes_for :product_images
  enum status: [["---",""], ["新品",0], ["未使用に近い",1], ["目立った傷や汚れなし",2], ["やや傷や汚れあり",4], ["傷や汚れあり",4], ["全体的に状態が悪い",5]]
  
end
