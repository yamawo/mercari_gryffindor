class ProductImage < ApplicationRecord
  belongs_to :product, dependent: :delete
end
