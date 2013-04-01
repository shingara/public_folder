def create_directory(name)
  d = Directory.new(:name => name)
  d.parent = Node.base_directory
  d.save
  d
end
