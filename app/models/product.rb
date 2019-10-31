class Product < ApplicationRecord
  
  belongs_to :user
  belongs_to :category
  belongs_to :brand, optional: true
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
  enum delivery_area: %i( -- 北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県 茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県 新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県 愛知県 三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県 鳥取県 島根県 岡山県 広島県 山口県 徳島県 香川県 愛媛県 高知県 福岡県 佐賀県 長崎県 )
  enum status: %i( --- 新品 未使用に近い 目立った傷や汚れなし やや傷や汚れあり 傷や汚れあり 全体的に状態が悪い )

  has_many :product_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  accepts_nested_attributes_for :product_images, allow_destroy: true

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
