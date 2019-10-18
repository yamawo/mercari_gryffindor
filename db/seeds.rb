# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "nokogiri"
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


Brand.create!(name: "シャネル")

Size.create!(name: "M")

10.times do |index|
  User.create!(email: "#{index}divnari@gmail.com", password: "00000000", password_confirmation: "00000000",last_name: "プログラ", first_name: "ミング", last_name_kana: "プログラ", first_name_kana: "ミング", birthdate_year: "2000", birthdate_month: "5", birthdate_day: "5", phone_number: "012011711#{index}", nickname: "divなり")
end

10.times do |index|
  Product.create!(name: "アイテム#{index}", price: "#{index}000", text: "アイテム#{index}のテキスト",status: "0", stage: "新品・未使用", delivery_responsivility: "送料込み(出品者負担)", delivery_way: "ゆうゆうメルカリ便", delivery_area: "大阪府", delivery_day: "1~2日で発送", created_at: "0000000#{index}", updated_at: "0000000#{index}", user_id: "1", category_id: "#{index + 3 }",brand_id: "1",size_id: "1")
end

# 10.times do |index|
#   ProductImage.create!(image: "https://shop.san-x.co.jp/img2/RLK/RLKK342_L.jpg", product_id: "1")
# end

# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m28401643310_1.jpg?1571399969", product_id: "2")
# end

# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m93982276842_2.jpg?1567847759", product_id: "3")
# end
# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m59909777168_1.jpg?1569741222", product_id: "4")
# end

# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m42139323625_1.jpg?1565424231", product_id: "5")
# end

# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m76269929399_1.jpg?1570024640", product_id: "6")
# end

# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m83789437406_1.jpg?1571400417", product_id: "7")
# end

# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m47679582011_1.jpg?1566294180", product_id: "8")
# end

# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m44363245810_1.jpg?1568509884", product_id: "9")
# end
# 10.times do |index|
#   ProductImage.create!(image: "https://static.mercdn.net/item/detail/orig/photos/m52200659324_1.jpg?1570694792", product_id: "10")
# end
