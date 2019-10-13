# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "nokogiri"
file = File.open("カテゴリー一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
doc = Nokogiri::HTML(file)

# lady = Category.create(name: "レディース")
doc.search("category-list-individual-box-root-category-name h3">

doc.search(".category-list-individual-box-sub-category-name h4").each do |ele|
  puts ele.content
  # Category.create(name: "#{ele.content}")
  # doc.search("")
end



# lady= Category.create(name: "レディース")
# man = Category.create(name: "メンズ")
# woman = Category.create(name: "ベビー・キッズ")
# woman = Category.create(name: "インテリア・住まい・小物")
# woman = Category.create(name: "本・音楽・ゲーム")
# woman = Category.create(name: "おもちゃ・ホビー・グッズ")
# woman = Category.create(name: "コスメ・香水・美容")
# woman = Category.create(name: "家電・スマホ・カメラ")
# woman = Category.create(name: "スポーツ・レジャー")
# woman = Category.create(name: "ハンドメイド")
# woman = Category.create(name: "チケット")
# lady= Category.create(name: "自動車・オートバイ")
# man = Category.create(name: "メンズ")
# woman = Category.create(name: "ベビー・キッズ")
# woman = Category.create(name: "インテリア・住まい・小物")
# woman = Category.create(name: "本・音楽・ゲーム")
# woman = Category.create(name: "おもちゃ・ホビー・グッズ")
# woman = Category.create(name: "コスメ・香水・美容")





# woman_tops = woman.children.create(name: "トップス")
# woman_outer = woman.children.create(name: "ジャケット・アウター")
# woman_pants = woman.children.create(name: "パンツ")
# woman_skirt = woman.children.create(name: "スカート")
# woman_dress = woman.children.create(name: "ワンピース")
# woman_shoes = woman.children.create(name: "靴")
# woman_pajama = woman.children.create(name: "ルームウェア/パジャマ")
# woman_legwear = woman.children.create(name: "レッグウェア")
# woman_hat = woman.children.create(name: "帽子")
# woman_bag = woman.children.create(name: "バッグ")
# woman_accessories = woman.children.create(name: "アクセサリー")
# woman_hearaccessories = woman.children.create(name: "ヘアアクセサリー")
# woman_smallarticle = woman.children.create(name: "小物")
# woman_watch = woman.children.create(name: "時計")
# woman_wig = woman.children.create(name: "ウィッグ/エクステ")
# woman_yakata-swimsuit = woman.children.create(name: "浴衣/水着")
# woman_suit-formal-dress = woman.children.create(name: "スーツ/フォーマル/ドレス")
# woman_maternity = woman.children.create(name: "浴衣/水着")
# woman_other = woman.children.create(name: "その他")


