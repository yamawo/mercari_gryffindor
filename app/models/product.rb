class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :user, dependent: :delete
  belongs_to :brand, optional: true, dependent: :delete
  belongs_to :size

  has_many :product_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  accepts_nested_attributes_for :product_images, allow_destroy: true
  
  with_options presence: true do
    validates :name
    validates :text
    validates :price
    validates :status
    validates :delivery_responsivility
    validates :delivery_way
    validates :delivery_area
    validates :delivery_day
    validates :category_id
    validates :user_id
  end

  enum status: %i( --- 新品 未使用に近い 目立った傷や汚れなし やや傷や汚れあり 傷や汚れあり 全体的に状態が悪い )
  

  def previous
    user.products.order('created_at desc, id desc').where('created_at <= ? and id < ?', created_at, id).first
  end

  def next
    user.products.order('created_at desc, id desc').where('created_at >= ? and id > ?', created_at, id).reverse.first
  end

  def liked? (like_user_id, like_product_id)
    likes.where(user_id: like_user_id, product_id: like_product_id).exists?
  end
  
end
