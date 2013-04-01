require 'spec_helper'

describe "Node routing" do
  it 'root directory' do
    expect({
      :get => '/'
    }).to route_to(
      :controller => 'nodes',
      :action => 'index'
    )
  end
end
