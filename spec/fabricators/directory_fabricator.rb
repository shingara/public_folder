def create_directory(name)
  d = Directory.new(:name => name)
  d.parent = Node.base_directory
  d.save
  d
end

def create_directory_from_parent(name, parent)
  d = Directory.new(:name => name)
  d.parent = parent
  d.save
  d
end
