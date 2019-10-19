class Product < ApplicationRecord
  belongs_to :user, dependent: :delete
  belongs_to :category
  belongs_to :brand
  belongs_to :size
  has_many :product_images
  has_many :likes, dependent: :destroy
  

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
