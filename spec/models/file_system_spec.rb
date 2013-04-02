require 'spec_helper'

describe FileSystem do
  let(:node) { Node.new(:dirname => 'bar') }
  let(:content_file) {
    t = Tempfile.new('foo')
    t.write 'hello world'
    t
  }
  let(:file) {
    ActionDispatch::Http::UploadedFile.new({
      :filename => 'foo.png',
      :type => 'png',
      :head => {},
      :tempfile => content_file
    })
  }
  let(:file_system) { FileSystem.new(node) }
  describe "#save" do
    context "with file pass" do
      before do
        file_system.file = file
      end

      it 'update name of node' do
        expect {
          file_system.save
        }.to change {
          node.name
        }.to('foo.png')
      end


      it 'update file_type of node' do
        expect {
          file_system.save
        }.to change {
          node.file_type
        }.to('png')
      end

      it 'update size of node' do
        expect {
          file_system.save
        }.to change {
          node.size
        }.to('hello world'.size)
      end

      it 'persist node' do
        expect {
          file_system.save
        }.to change {
          node.persisted?
        }.to(true)
      end

      it 'write file in disk' do
        expect {
          file_system.save
        }.to change {
          File.exist?(File.join(
            PublicFolder::Application.config.file_system,
            'bar/foo.png'
          ))
        }.to(true)
      end
    end
  end
end
