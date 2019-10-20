# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "nokogiri"
require 'base64'

#サイズデータ取得
file = File.open("商品検索結果【メルカリ】No.1フリマアプリ.html")
doc = Nokogiri::HTML(file)

size_blocks = doc.search(".checkbox-default")
size_id = 1
size_blocks[1168..1297].each_with_index do |size_block, i|
  size_name = size_block.at("label").inner_text
  size = Size.create(name: "#{size_name}")
  size_id += 1
end

#カテゴリーデータ取得
file = File.open("カテゴリー一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

parent_category_blocks = doc.search(".category-list-individual-box")
category_id = 1
parent_category_blocks.each_with_index do |parent_category_block,i| 
  parent_category = parent_category_block.at("h3").inner_text
  genre = Category.create(name: "#{parent_category}")
  category_id += 1
  child_category_blocks = parent_category_block.search(".category-list-individual-box-sub-sub-category-box")
  child_category_names = parent_category_block.search(".category-list-individual-box-sub-category-name")
  child_category_blocks.each_with_index do |child_category_block, i|
    child_category = child_category_names[i].at("h4").inner_text
    genre2 = genre.children.create(name: "#{child_category}")
    category_id += 1
    grandchild_category_blocks = child_category_block.search(".category-list-individual-box-sub-sub-category-name")
    grandchild_category_blocks.each do |grandchild_category_block|
      grandchild_category = grandchild_category_block.at("a").inner_text
      next if grandchild_category.squish == "すべて"
      genre2.children.create(name: "#{grandchild_category}")
      category_id += 1
    end
  end
end

#ブランド取得
file = File.open("レディース ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  Brand.create(name: "#{brand}")
  brand_id += 1
end



file = File.open("メンズ ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end



file = File.open("ベビー・キッズ ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("インテリア・住まい・雑貨 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("キッチン・食器 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("時計 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end



file = File.open("コスメ・香水・美容 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("テレビゲーム ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end



file = File.open("スポーツ・レジャー ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("スマートフォン・携帯電話 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end



file = File.open("バイク ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end



file = File.open("楽器 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("自動車パーツ ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("食品 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("国内自動車本体 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


file = File.open("外国自動車本体 ブランド一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

brand_blocks = doc.search(".brand-list-initial-box-brand-name")

brand_id = 1
brand_blocks.each do |brand_block|
  brand = brand_block.at("p").inner_text
  unless Brand.find_by(name: "#{brand}")
    Brand.create(name: "#{brand}")
    brand_id += 1
  end
end


10.times do |index|
  User.create!(email: "#{index}divnari@gmail.com", password: "00000000", password_confirmation: "00000000",last_name: "プログラ", first_name: "ミング", last_name_kana: "プログラ", first_name_kana: "ミング", birthdate_year: "2000", birthdate_month: "5", birthdate_day: "5", phone_number: "012011711#{index}", nickname: "divなり#{index + 1}")
end

10.times do |index|
  Product.create!(name: "アイテム#{index + 1}", price: "#{index + 1}000", text: "アイテム#{index}のテキスト",status: "0", stage: "新品・未使用", delivery_responsivility: "送料込み(出品者負担)", delivery_way: "ゆうゆうメルカリ便", delivery_area: "大阪府", delivery_day: "1~2日で発送", created_at: "0000000#{index}", updated_at: "0000000#{index}", user_id: "1", category_id: "#{index + 202 }",brand_id: "1",size_id: "1")
end

10.times do |index|
  Product.create!(name: "アイテム#{index + 11}", price: "#{index + 11}000", text: "アイテム#{index}のテキスト",status: "0", stage: "新品・未使用", delivery_responsivility: "送料込み(出品者負担)", delivery_way: "ゆうゆうメルカリ便", delivery_area: "大阪府", delivery_day: "1~2日で発送", created_at: "0000000#{index}", updated_at: "0000000#{index}", user_id: "1", category_id: "#{index + 3 }",brand_id: "2",size_id: "1")
end


ProductImage.create!(image: open("#{Rails.root}/public/images/シャネル1.jpg"), product_id: "1")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "1")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "1")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "1")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "1")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "1")

ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "11")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "12")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "13")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "14")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "15")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "16")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "17")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "18")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "19")
ProductImage.create!(image: open("#{Rails.root}/public/images/レディース1.jpg"), product_id: "20")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "12")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "13")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "14")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "15")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "16")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "17")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "18")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "19")

# ProductImage.create!(image: open("#{Rails.root}/app/assets/images/レディース1.jpg"), product_id: "20")

# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "2")  
# end

# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "3")  
# end

# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "4")  
# end

# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "5")  
# end

# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "6")  
# end
# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "7")  
# end

# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "8")  
# end

# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "9")  
# end

# 10.times do |index|
#   ProductImage.create!(image: open("#{Rails.root}/app/assets/images/シャネル1.jpg"), product_id: "10")  
# end