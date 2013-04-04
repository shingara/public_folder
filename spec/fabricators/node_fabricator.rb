
def create_content_file(name, content)
  t = Tempfile.new(name)
  t.write content

  ActionDispatch::Http::UploadedFile.new({
    :filename => name,
    :type => File.extname(name),
    :head => {},
    :tempfile => t
  })
end

def create_node_from_parent(name, content, parent)
  Node.create(
    :dirname => parent.full_path,
    :content => create_content_file(name, content)
  )
end
