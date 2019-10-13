class Address < ApplicationRecord

  belongs_to :user, optional: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  with_options presence: true do
      validates :last_name, on: :validates_step6
      validates :first_name, on: :validates_step6
      validates :last_name_kana, on: :validates_step6
      validates :first_name_kana, on: :validates_step6
      validates :postal_code, on: :validates_step6
      validates :address_prefecture, on: :validates_step6
      validates :address_city, on: :validates_step6
      validates :address_number, on: :validates_step6
  end
end
