require 'rails_helper'

describe PubsController do 
  describe "GET index" do 
    it "sets @pubs" do 
      pub1 = Fabricate(:pub)
      pub2 = Fabricate(:pub)
      get :index
      expect(assigns(:pubs)).to match_array([pub1, pub2])
    end
  end
end