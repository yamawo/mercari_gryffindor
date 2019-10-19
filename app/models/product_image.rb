class ProductImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :product, dependent: :delete, optional: true  
end
