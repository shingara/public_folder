class Node < ActiveRecord::Base
  attr_accessible :file_type, :name, :dirname, :content

  validates_presence_of :file_type, :size
  validates_uniqueness_of :name, :scope => :parent_id

  belongs_to :parent, :class_name => "Node"
  has_many :childs, :class_name => "Node", :dependent => :destroy, :foreign_key => :parent_id

  before_save :update_full_path

  def full_path
    paths.join('/')
  end

  def valid_order(order='')
    case order
    when 'date'
      'created_at'
    when 'type'
      'file_type'
    else
      order.blank? ? 'name' : order
    end
  end

  def order_childs(order='name')
    childs.order(valid_order(order))
  end

  def update_full_path
    self.full_path = full_path
  end

  def paths
    if parent
      parent.paths + [ name ]
    else
      [ name ]
    end
  end

  def parents
    if parent
      parent.parents | [ parent ]
    else
      []
    end
  end

  def dirname=(path)
    self.parent = Node.get(path)
    @dirname = path
  end

  def dirname
    @dirname ||= parent.full_path
  end

  def content=(file)
    filesystem.file = file
    filesystem.save
  end
  def content
    filesystem.path
  end

  def directory?
    false
  end

  def self.get(path)
    path = (path || '').split('/')
    return base_directory if path.empty?
    Node.where(
      :name => path.last,
      :full_path => path.join('/')
    ).first
  end

  def self.base_directory
    Directory.where(:name => '', :full_path => '', :parent_id => nil).first_or_create
  end

  private

  def filesystem
    @filesystem ||= FileSystem.new(self)
  end

end
