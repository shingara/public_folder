class Directory < Node

  after_initialize do
    self.file_type = 'directory'
    self.size = 0
  end

end
