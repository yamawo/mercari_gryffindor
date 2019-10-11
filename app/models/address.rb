class Address < ApplicationRecord
  with_options presence: true do
         validates :postal_code
         validates :address_prefecture
         validates :address_city
         validates :address_number
  end
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
