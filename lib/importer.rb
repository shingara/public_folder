require 'mime/types'
class Importer
  def initialize(path)
    @path = path
  end

  def import
    Dir.chdir(@path)
    Dir.glob('**/*').each do |d|
      if File.directory?(d)
        Directory.create!(
          :dirname => dirname(d),
          :name => File.basename(d)
        )
      else
        Node.create!(
          :dirname => dirname(d),
          :content => ActionDispatch::Http::UploadedFile.new(
            :filename => File.basename(d),
            :type => content_type(File.basename(d)),
            :tempfile => File.open(d)
          )
        )
      end
    end
  end

  def content_type(basename)
    type_for = MIME::Types.type_for(basename)
    type_for.empty? ? 'application/octet-stream' : type_for.first.content_type
  end

  def dirname(d)
    File.dirname(d) == '.' ? '/' : "/#{File.dirname(d)}"

  end
end
