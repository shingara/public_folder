class NodeDecorator < Draper::Decorator
  decorates :node
  delegate :file_type

  def name
    h.link_to model.name, url
  end

  def size
    h.number_to_human_size(model.size)
  end

  def directory_decorate
    DirectoryDecorator.new(model)
  end
  delegate :url, :to => :directory_decorate

  def directory_url
    DirectoryDecorator.new(model.parent).url
  end

  def created_at
    I18n.l(model.created_at)
  end

end
