class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand, optional: true
  has_many :product_images
  accepts_nested_attributes_for :product_images, allow_destroy: true

  belongs_to :user, dependent: :delete
  belongs_to :brand, optional: true, dependent: :delete
  belongs_to :size

  with_options presence: true do
    validates :name
    validates :text
    validates :price
    validates :status
    validates :delivery_responsivility
    validates :delivery_way
    validates :delivery_area
    validates :delivery_day
    validates :category_id
    validates :user_id
  end

  enum status: %i( --- 新品 未使用に近い 目立った傷や汚れなし やや傷や汚れあり 傷や汚れあり 全体的に状態が悪い )
end
