require 'spec_helper'
require 'shoulda/matchers/active_model'
require 'shoulda/matchers/active_record'

describe Node do


  describe "Validation" do
    include Shoulda::Matchers::ActiveModel

    it { should validate_uniqueness_of(:name).scoped_to(:parent_id) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:file_type) }
    it { should validate_presence_of(:size) }
  end

  describe "Associations" do

    include Shoulda::Matchers::ActiveRecord

    it { should belong_to(:parent).class_name(Node) }
    it { should have_many(:childs).class_name("Node").dependent(:destroy) }
  end
end
