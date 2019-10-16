# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "nokogiri"

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

