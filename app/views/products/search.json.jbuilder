json.array! @brand.each do |brand|
  json.name brand.name
  json.id brand.id
end