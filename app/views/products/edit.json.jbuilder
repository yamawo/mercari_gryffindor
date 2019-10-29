json.(@parent, :id)
json.parent_id @parent.id
json.(@child, :id)
json.child_id @child.id
json.(@grandchild, :id)
json.grandchild_id @grandchild.id
if @size
    json.(@size, :id)
    json.size_id @size.id
end
if @brand
    json.(@brand, :name, :id)
    json.brand_name @brand.name
    json.brand_id @brand.id
end