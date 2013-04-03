class NodesController < ApplicationController
  expose(:node) {
    Node.get(request.path)
  }

  expose(:node_decorate) { DirectoryDecorator.new(node) }

  def index
    raise  ActionController::RoutingError.new('not found') unless node
    unless node.directory?
      send_file node.content
    end
  end
end
