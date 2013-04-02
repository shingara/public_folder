class NodeDecorator < Draper::Decorator
  decorates :node

  def name
    h.link_to model.name, url
  end

  def directory_decorate
    if model.directory?
      DirectoryDecorator.new(model)
    else
      DirectoryDecorator.new(model.parent)
    end
  end
  delegate :url, :to => :directory_decorate

end
