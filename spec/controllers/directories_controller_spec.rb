require 'spec_helper'

describe DirectoriesController do

  describe "POST create" do
    let(:directory) {
      double(:directory,
             :attributes= => true, :save => true )
    }
    before do
      Directory.stub(:new).and_return(
        directory
      )
    end
    context "with successfull directory creation" do
      let(:directory) {
        d = double(:directory)
        d.should_receive(:attributes=).with('name' => 'foo')
        d.should_receive(:save).and_return(true)
        d.stub(:paths).and_return(['foo'])
        d
      }

      it 'redirect to his url' do
        post :create, :directory => {:name => 'foo'}
        expect(response).to redirect_to('/foo')
      end
    end
  end

end
