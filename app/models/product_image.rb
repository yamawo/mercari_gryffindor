class ProductImage < ApplicationRecord
  belongs_to :product, dependent: :delete
  belongs_to :user, dependent: :delete
end
