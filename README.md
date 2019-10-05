# README

## usersテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|nickname|string|null: false|
|address|string|null: false|
|text|text|
|image|string|
|good|integer|default: 0|
|normal|integer|default: 0|
|bad|integer|default: 0|


### Association
- has_many :products
- has_one :credit


## puroductssテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|price|integer|null: false|
|text|text|null: false|
|image|string|null: false|
|status|string|null: false|
|stage|string|null: false|
|delivery_responsivility|string|null: false|
|delivery_way|string|null: false|
|delivery_area|string|null: false|
|delivery_day|string|null: false|
|saler_id|references|null: false, foreign_key: true|
|buyer_id|references|foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|foreign_key|
|size_id|references|foreign_key|


### Association
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to :size

## messagesテーブル

|Column|Type|Option|
|------|----|------|
|body|text|
|image|string|
|user_id|references|null: false, foreign_key: true|
|group_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group

## users_groupsテーブル

|Column|Type|Option|
|------|----|------|
|user_id|references|null: false, foreign_key: true|
|group_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group
