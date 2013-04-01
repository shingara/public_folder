class Node < ActiveRecord::Base
  attr_accessible :file_type, :name, :parent_id, :size

  validates_presence_of :name, :file_type, :size
  validates_uniqueness_of :name, :scope => :parent_id

  belongs_to :parent, :class_name => "Node"
  has_many :childs, :class_name => "Node", :dependent => :destroy, :foreign_key => :parent_id

  before_save :update_full_path

  def full_path
    paths.join('/')
  end

  def update_full_path
    self.full_path = full_path
  end

  def paths
    if parent
      parent.paths | [ name ]
    else
      [ name ]
    end
  end


  def self.get(path)
    path ||= []
    Node.where(
      :name => path.last,
      :full_path => path.join('/')
    ).first
  end

end
