require 'spec_helper'

describe FilesController do
  describe "GET /new" do
    before { get :new, :dirname => '/foo' }
    it { expect(response).to render_template(:new) }
  end
end
