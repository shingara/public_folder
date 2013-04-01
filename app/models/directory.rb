class Directory < Node

  after_initialize do
    self.file_type = 'directory'
    self.size = 0
  end

  def dirname=(path)
    self.parent = Node.get(path)
  end

  def dirname
    @dirname ||= parent.full_path
  end

  def directory?; true; end

end
