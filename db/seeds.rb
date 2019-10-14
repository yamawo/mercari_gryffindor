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


# doc.search(".category-list-individual-box-root-category-name")[0..12].each do |ele|
#   genre = Category.create(name: "#{ele.content}")
#   doc.search(".category-list-individual-box-inner-box:has(.category-list-individual-box-sub-category-name)")[0..12].each do |box|
#     num = box.search(".category-list-individual-box-sub-category-name").length
#     doc.search(".category-list-individual-box-sub-category-name h4")[0..num].each do |item|
#       genre2 = genre.children.create(name: "#{item.content}")
#       doc.search(".category-list-individual-box-sub-sub-category-box:has(.category-list-individual-box-sub-sub-category-name)")[0..num].each do |smallbox|
#         count = smallbox.search(".category-list-individual-box-sub-sub-category-name").length
#         doc.search(".category-list-individual-box-sub-category-name a")[0..count].each do |cate|
#           genre2.children.create(name: "#{cate.content}")
#         end
#       end
#     end
#   end
# end
  
for doc.search(".category-list-individual-box-inner-box:has(.category-list-individual-box-sub-category-name)") in 0..12 do
  num = box.search(".category-list-individual-box-sub-category-name").length
  for doc.search(".category-list-individual-box-sub-sub-category-box:has(.category-list-individual-box-sub-sub-category-name)") in 0..num do 
    puts smallbox.search(".category-list-individual-box-sub-sub-category-name").length
  end

end
