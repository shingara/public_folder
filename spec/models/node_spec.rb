require 'spec_helper'
require 'fabricators/directory_fabricator'
require 'shoulda/matchers/active_model'
require 'shoulda/matchers/active_record'

describe Node do

  describe "Validation" do
    include Shoulda::Matchers::ActiveModel

    it { should validate_uniqueness_of(:name).scoped_to(:parent_id) }

    it { should validate_presence_of(:file_type) }
    it { should validate_presence_of(:size) }
  end

  describe "Associations" do

    include Shoulda::Matchers::ActiveRecord

    it { should belong_to(:parent).class_name(Node) }
    it { should have_many(:childs).class_name("Node").dependent(:destroy) }

  end

  describe "#full_path" do
    context "without parent" do
      it 'only name' do
        expect(
          Directory.create(:name => 'foo').full_path
        ).to eq 'foo'
      end

      it 'with parent' do
        parent_directory = Directory.create(:name => 'bar')
        directory = Directory.create(:name => 'foo')
        directory.parent = parent_directory
        directory.save
        expect(
          directory.full_path
        ).to eq 'bar/foo'
      end
    end
  end

  describe ".get" do
    context "on first level" do
      let!(:directory) { create_directory('foo') }

      it 'with path known' do
        expect(Node.get('foo')).to eq directory
      end

      it 'with path known' do
        expect(Node.get('foo')).to eq directory
      end

      it 'with path known' do
        expect(Node.get('bar')).to eq nil
      end

    end

    context "on second level" do

      let!(:parent_directory) { create_directory('bar') }
      let!(:directory) {
        d = Directory.create(:name => 'foo')
        d.parent = parent_directory
        d.save
        d
      }

      it 'with path known' do
        expect(Node.get('bar/foo')).to eq directory
      end

      it 'with unknown path' do
        expect(Node.get('bar/bar')).to eq nil
      end
    end

    context "without base node and request it" do
      it 'create node master' do
        expect{
          Node.get('')
        }.to change {
          Node.count
        }.from(0).to(1)
      end

      it 'create node master' do
        expect{
          Node.get(nil)
        }.to change {
          Node.count
        }.from(0).to(1)
      end

      context "if exist" do
        let!(:node) { Directory.create!(:name => '') }
        it 'get it' do
          expect(Node.get('')).to eq node
        end

      end
    end
  end

end
