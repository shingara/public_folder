require 'spec_helper'

describe "File routing" do
  it 'new file' do
    expect({
      :get => '/files/new'
    }).to route_to(
      :controller => 'files',
      :action => 'new'
    )
  end

  it 'create file' do
    expect({
      :post => '/files'
    }).to route_to(
      :controller => 'files',
      :action => 'create'
    )
  end
end
