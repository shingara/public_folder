class DirectoryDecorator < Draper::Decorator
  decorates :directory

  def url
    h.url_for(
      :controller => 'nodes',
      :action => 'index',
      :path => model.paths
    )
  end

end
