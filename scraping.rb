# parent_category_blocks = doc.search(".category-list-individual-box")
# category_id = 1
# parent_category_blocks.each_with_index do |parent_category_block,i| 
#   parent_category = parent_category_block.at("h3").inner_text
#   genre = Category.create(name: "#{parent_category}")#レディース
#   category_id += 1
#   child_category_blocks = parent_category_block.search(".category-list-individual-box-sub-sub-category-box")
#   child_category_names = parent_category_block.search(".category-list-individual-box-sub-category-name")
#   child_category_blocks.each_with_index do |child_category_block, i|
#     child_category = child_category_names[i].at("h4").inner_text
#     genre2 = genre.children.create(name: "#{child_category}")
#     category_id += 1
#     grandchild_category_blocks = child_category_block.search(".category-list-individual-box-sub-sub-category-name")
#     grandchild_category_blocks.each do |grandchild_category_block|
#       grandchild_category = grandchild_category_block.at("a").inner_text
#       next if grandchild_category.squish == "すべて"
#       genre2.children.create(name: "#{grandchild_category}")
#       category_id += 1
#     end
#   end
# end



# def self.categories ## カテゴリーのスクレイピング
#   agent = Mechanize.new
#   current_page = agent.get("http://localhost:3000/items/scraping_category")

#   parent_category_blocks = current_page.search('.category-list-individual-box')
#   category_id = 1
#   parent_category_blocks.each_with_index do |parent_category_block,i| ## 親カテゴリの配列を回す。
#     parent_category = parent_category_block.at('h3').inner_text
#     @parent_category = Category.where(id: category_id, name: parent_category).first_or_create ## 親カテゴリをcreate
#     category_id += 1
#     child_category_blocks = parent_category_block.search('.category-list-individual-box-sub-sub-category-box')
#     child_category_names = parent_category_block.search('.category-list-individual-box-sub-category-name')
#     child_category_blocks.each_with_index do |child_category_block, i| ## 子カテゴリの配列を回す。
#       child_category = child_category_names[i].at('h4').inner_text
#       @child_category = @parent_category.children.where(id: category_id, name: child_category).first_or_create ## 子カテゴリをcreate
#       category_id += 1
#       grandchild_category_blocks = child_category_block.search('.category-list-individual-box-sub-sub-category-name')
#       grandchild_category_blocks.each do |grandchild_category_block| ## 孫カテゴリの配列を回す。
#         grandchild_category = grandchild_category_block.at('a').inner_text
#         ## squish = 先頭と末尾の改行やスペースなどを除去するメソッド
#         next if grandchild_category.squish == "すべて" ## すべてはカテゴリーに含めない
#         @grandchild_category = @child_category.children.where(id: category_id, name: grandchild_category.squish).first_or_create ## 孫カテゴリをcreate
#         category_id += 1
#       end
#     end

#   end
#   return 0
# end


# doc.search(".")[0..12].each do |ele|
#   genre = Category.create(name: "#{ele.content}")#レディース
#   doc.search(".category-list-individual-box-inner-box:has(.category-list-individual-box-sub-category-name)").each do |box|
#     num = box.search(".category-list-individual-box-sub-category-name").length
#     box.search(".category-list-individual-box-sub-category-name")[0..num].each do |item|
#       genre2 = genre.children.create(name: "#{item.content}")#トップス
#       box.search(".category-list-individual-box-sub-sub-category-box:has(.category-list-individual-box-sub-sub-category-name)").each do |list|
#       count = list.search(".category-list-individual-box-sub-sub-category-name").length
#         list.search(".category-list-individual-box-sub-sub-category-name")[1..count].each do |cate|
#           genre2.children.create(name: "#{cate.content}")#トップス以下すべて
#         end
#       end
#     end
#   end
# end
  
# doc.search(".category-list-individual-box-inner-box:has(.category-list-individual-box-sub-category-name)")[0..12].each do |box|
#   puts num = box.search(".category-list-individual-box-sub-category-name").length
#   doc.search(".category-list-individual-box-sub-sub-category-box:has(.category-list-individual-box-sub-sub-category-name)")[0..num].each do |smallbox|
#     puts smallbox.search(".category-list-individual-box-sub-sub-category-name").length
#   end
# end

#   box = ele.search(".category-list-individual-box-sub-sub-category-box")
#     num = box.search(".category-list-individual-box-sub-category-name").length
#     box.search(".category-list-individual-box-sub-category-name")[0..num].each do |item|
#       genre2 = genre.children.create(name: "#{item.content}")#トップス
#       box.search(".category-list-individual-box-sub-sub-category-box").each do |list|
#       count = list.search(".category-list-individual-box-sub-sub-category-name").length
#         list.search(".category-list-individual-box-sub-sub-category-name")[1..count].each do |cate|
#           genre2.children.create(name: "#{cate.content}")#トップス以下すべて
#         end
#       end
#     end
  
# end







#本物

# require "nokogiri"
# file = File.open("カテゴリー一覧 - メルカリ スマホでかんたん フリマアプリ.htm")
# doc = Nokogiri::HTML(file)






# parent_category_blocks = doc.search(".category-list-individual-box")
# category_id = 1
# parent_category_blocks.each_with_index do |parent_category_block,i| 
#   parent_category = parent_category_block.at("h3").inner_text
#   genre = Brand.create(name: "#{parent_category}")#レディース
#   category_id += 1
#   child_category_blocks = parent_category_block.search(".category-list-individual-box-sub-sub-category-box")
#   child_category_names = parent_category_block.search(".category-list-individual-box-sub-category-name")
#   child_category_blocks.each_with_index do |child_category_block, i|
#     child_category = child_category_names[i].at("h4").inner_text
#     genre2 = genre.children.create(name: "#{child_category}")
#     category_id += 1
#     grandchild_category_blocks = child_category_block.search(".category-list-individual-box-sub-sub-category-name")
#     grandchild_category_blocks.each do |grandchild_category_block|
#       grandchild_category = grandchild_category_block.at("a").inner_text
#       next if grandchild_category.squish == "すべて"
#       genre2.children.create(name: "#{grandchild_category}")
#       category_id += 1
#     end
#   end
# end