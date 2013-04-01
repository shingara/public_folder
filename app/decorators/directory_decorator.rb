class DirectoryDecorator < Draper::Decorator
  decorates :directory
  delegate :full_path

  def url
    h.url_for(
      :controller => 'nodes',
      :action => 'index',
      :path => model.paths,
      :host => h.request.host
    )
  end

  def name
    model.name.blank? ? '.' : model.name
  end

  def ls
    NodeDecorator.decorate_collection(
      model.childs
    )
  end

  def parents
    DirectoryDecorator.decorate_collection(model.parents)
  end

end
