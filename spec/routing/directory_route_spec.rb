require 'spec_helper'

describe "Directory routing" do
  it 'new directory' do
    expect({
      :get => '/directories/new'
    }).to route_to(
      :controller => 'directories',
      :action => 'new'
    )
  end

  it 'create directory' do
    expect({
      :post => '/directories'
    }).to route_to(
      :controller => 'directories',
      :action => 'create'
    )
  end
end
