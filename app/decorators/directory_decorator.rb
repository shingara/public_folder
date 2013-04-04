class DirectoryDecorator < Draper::Decorator
  decorates :directory
  delegate :full_path

  def url(params={})
    h.url_for({
      :controller => 'nodes',
      :action => 'index',
      :path => model.paths,
      :host => h.request.host
    }.merge(params))
  end

  def name
    model.name.blank? ? '.' : model.name
  end

  def ls(order='name')
    NodeDecorator.decorate_collection(
      model.order_childs(order)
    )
  end

  def parents
    DirectoryDecorator.decorate_collection(model.parents)
  end

  def order_by_link(order)
    h.link_to I18n.t("decorator.node.order.#{order}"), url(:order => order)
  end

  def order_active?(order)
    (order == h.params[:order] || (h.params[:order].blank? && order == 'name')) ? 'active' : ''
  end

end
