
json.array! @children.each do |child|
  json.id child.id
  json.name child.name
  json.child child
end
json.children @children