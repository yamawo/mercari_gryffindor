class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :address
  accepts_nested_attributes_for :address

  with_options presence: true do
         validates :last_name
         validates :first_name
         validates :last_name_kana
         validates :first_name_kana
         validates :birthdate_year
         validates :birthdate_month
         validates :birthdate_day
         validates :email
         validates :phone_number
         validates :nickname
         validates :password_confirmation 
  end
         validates :password, confirmation: true
end
