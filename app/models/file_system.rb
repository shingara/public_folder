class FileSystem < Struct.new(:node)

  attr_writer :file

  ##
  # Persist node with data from file
  #
  def save
    node.name = @file.original_filename
    node.file_type = @file.content_type
    node.size = @file.tempfile.size
    save_file
    node.save
  end

  def path
    File.join(dirname, node.name)
  end

  private

  def save_file
    FileUtils.mkdir_p(dirname)
    FileUtils.mv(@file.path, path)
  end

  def dirname
    File.join(
      PublicFolder::Application.config.file_system,
      node.dirname
    )
  end


end
