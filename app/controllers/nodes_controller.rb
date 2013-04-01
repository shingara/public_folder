class NodesController < ApplicationController
  expose(:node) {
    Node.get(params[:path])
  }
  def index
    raise  ActionController::RoutingError.new('not found') unless node
  end
end
