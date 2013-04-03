require 'spec_helper'

describe NodesController do

  describe "GET :index" do
    context "without directory found" do
      before do
        Node.should_receive(:get).with("/foo").and_return(nil)
      end

      it {
        expect {
        get :index, :path => ['foo']
        }.to raise_error(ActionController::RoutingError)
      }
    end

    context "with directory found" do
      before do
        Node.should_receive(:get).with("/foo").and_return(Directory.new)
      end

      it {
        get :index, :path => ['foo']
        expect(response).to render_template('index')
      }
    end

  end

end
