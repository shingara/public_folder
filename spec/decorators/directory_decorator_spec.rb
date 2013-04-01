require 'spec_helper'
require 'draper/view_context'

describe DirectoryDecorator do

  let(:decorator) { DirectoryDecorator.new(directory) }
  before do
    Draper::ViewContext.clear!
    Draper::ViewContext.current.controller.request.host = 'test.host'
  end
  describe "#url" do
    context "with directory without parent" do
      let(:directory) { Directory.new(:name => 'foo') }
      it 'return the complete url' do
        expect(decorator.url).to eq 'http://test.host/foo'
      end
    end
    context "with directory with parent" do
      let(:directory) {
        d = Directory.new(:name => 'foo')
        child = Directory.new(:name => 'bar')
        child.parent = d
        child
      }
      it 'return complete url' do
        expect(decorator.url).to eq 'http://test.host/foo/bar'
      end
    end
  end
end
