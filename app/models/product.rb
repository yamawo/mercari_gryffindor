class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images
  accepts_nested_attributes_for :product_images
  belongs_to :user, dependent: :delete
  belongs_to :brand
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

end
