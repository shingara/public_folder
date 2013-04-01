class NodesController < ApplicationController
  expose(:node) {
    Node.get(params[:path])
  }

  expose(:node_decorate) { DirectoryDecorator.new(node) }

  def index
    raise  ActionController::RoutingError.new('not found') unless node
  end
end
