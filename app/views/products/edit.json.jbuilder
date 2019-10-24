json.(@parent, :name)
json.parent_name @parent.name
json.(@child, :name)
json.child_name @child.name
json.(@grandchild, name)
json.grandchild_name @grandchild.name