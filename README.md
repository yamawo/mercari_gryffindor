# README

## usersテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|nickname|string|null: false|
|text|text|
|image|string|
|good|integer|default: 0|
|normal|integer|default: 0|
|bad|integer|default: 0|

### Association
- has_many :products
- has_many :likes
- has_one :credit
- has_one :address

## addressテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null :false|
|user_id|references|foreign_key: true, null: false|
|postal_code|integer|null :false|

### Association
- belongs_to :user, dependent: :delete

## creditsテーブル

|Column|Type|Option|
|------|----|------|
|user_id|references|foreign_key: true|
|card_id|references|foreign_key: true|
|customer_id|references|foreign_key: true|

### Association
- belongs_to :user, dependent: :delete

## puroductsテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|price|integer|null: false|
|text|text|null: false|
|status|integer|null: false|
|stage|string|null: false|
|delivery_responsivility|string|null: false|
|delivery_way|string|null: false|
|delivery_area|string|null: false|
|delivery_day|string|null: false|
|user_id|references|null: false, foreign_key: true|
|buyer_id|references|foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|foreign_key :true|
|size_id|references|foreign_key :true|

### Association
- belongs_to :user, dependent: :delete
- belongs_to :category
- belongs_to :brand
- belongs_to :size
- has_many :likes
- has_many :product_images

## product_imagesテーブル

|Column|Type|Option|
|------|----|------|
|image|string|
|product_id|references|foreign_key :true|

### Association
- belongs_to :product, dependent: :delete

## likesテーブル
|Column|Type|Option|
|------|----|------|
|user_id|references|foreign_key: true|
|product_id|references|foreign_key: true|

### Association
- belongs_to :user, dependent: :delete
- belongs_to :product, dependent: :delete

## categorysテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null :false|

### Association
- has_many :products

## brandsテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null: false|

### Association
- has_many :products

## sizesテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null: false|

### Association
- has_many :products