class Product < ApplicationRecord
  belongs_to :category
  has_many :product_images
  accepts_nested_attributes_for :product_images
  belongs_to :user, dependent: :delete
  belongs_to :brand, optional: true, dependent: :delete
  belongs_to :size

  with_options presence: true do
    validates :name, on: :valid_create
    validates :text, presence: { message: "入力してください"}
    validates :price, presence: { message: "入力してください"}
    validates :status, presence: { message: "入力してください"}
    validates :delivery_responsivility, presence: { message: "入力してください"}
    validates :delivery_way, presence: { message: "を入力してください"}
    validates :delivery_area, presence: { message: "を入力してください"}
    validates :delivery_day, presence: { message: "を入力してください"}
    validates :category_id, presence: { message: "を入力してください"}
    validates :user_id
  end

  enum status: %i( --- 新品 未使用に近い 目立った傷や汚れなし やや傷や汚れあり 傷や汚れあり 全体的に状態が悪い )
end
