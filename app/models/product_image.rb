class ProductImage < ApplicationRecord
<<<<<<< Updated upstream
    mount_uploader :image, ImageUploader
    belongs_to :product, optional: true      #外部キーのnilを許可
=======
  belongs_to :product, dependent: :delete
  # belongs_to :user, dependent: :delete
>>>>>>> Stashed changes
end
