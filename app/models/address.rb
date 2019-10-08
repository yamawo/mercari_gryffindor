class Address < ApplicationRecord

  belongs_to :user

  with_options presence: true do
         validates :postal_code
         validates :address_prefecture
         validates :address_city
         validates :address_number
  end
end
