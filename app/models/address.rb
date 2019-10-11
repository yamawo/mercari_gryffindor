class Address < ApplicationRecord

  belongs_to :user, optional: true

  # with_options presence: true do
  #     validates :last_name
  #     validates :first_name
  #     validates :last_name_kana
  #     validates :first_name_kana
  #     validates :postal_code
  #     validates :address_prefecture
  #     validates :address_city
  #     validates :address_number
  # end
end
