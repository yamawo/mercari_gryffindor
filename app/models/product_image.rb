class ProductImage < ApplicationRecord
    mount_uploader :image, ImageUploader
    belongs_to :product, optional: true      #外部キーのnilを許可
    validates :image, presence: true 
        
    
end
