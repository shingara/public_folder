require 'spec_helper'
require 'draper/view_context'

describe DirectoryDecorator do

  let(:decorator) { DirectoryDecorator.new(directory) }
  describe "#url" do
    context "with directory without parent" do
      let(:directory) { Directory.new(:name => 'foo') }
      it 'return the complete url' do
        expect(decorator.url).to eq '/foo'
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
        expect(decorator.url).to eq '/foo/bar'
      end
    end
  end
end
