class NodeDecorator < Draper::Decorator
  decorates :node

  def name
    h.link_to model.name, url
  end

  def decorate
    if model.directory?
      DirectoryDecorator.new(model)
    else
      self
    end
  end
  delegate :url, :to => :decorate

end
