class Node < ActiveRecord::Base
  attr_accessible :created_at, :file_type, :name, :parent_id, :size

  validates_presence_of :name, :created_at, :file_type, :size
  validates_uniqueness_of :name, :scope => :parent_id

  belongs_to :parent, :class_name => "Node"
  has_many :childs, :class_name => "Node", :dependent => :destroy, :foreign_key => :parent_id

end
