require 'spec_helper'

describe Directory do
  it { should be_a(Node) }

  describe "#file_type" do
    it 'a directory' do
      expect(Directory.new.file_type).to eq 'directory'
    end

    context "with persist" do
      it 'fix file_type' do
        d = Directory.create!(
          :name => 'foo',
        )
        expect(d.reload.file_type).to eq 'directory'
      end
    end
  end

  describe "#size" do
    it 'a directory' do
      expect(Directory.new.size).to eq 0
    end

    context "with persist" do
      it 'fix size' do
        d = Directory.create!(
          :name => 'foo',
        )
        expect(d.reload.size).to eq 0
      end
    end
  end

  describe "#paths" do
    context "without parent" do
      let(:directory) { Directory.new(:name => 'foo') }
      it 'only name' do
        expect(directory.paths).to eq ['foo']
      end
    end

    context "with parent" do
      let(:big_parent_directory) { Directory.new(:name => 'baz') }
      let(:parent_directory) {
        d = Directory.new(:name => 'bar')
        d.parent = big_parent_directory
        d
      }
      let(:directory) {
        d = Directory.new(:name => 'foo')
        d.parent = parent_directory
        d
      }
      it 'only name' do
        expect(directory.paths).to eq ['baz', 'bar', 'foo']
      end
    end
  end


end
