class Product < ApplicationRecord
  # accepts_nested_attributes_for :product_images
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to :size
  has_many :product_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  

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
