require 'rails_helper'

describe RelationshipsController do 
  describe "GET index" do 
    it "sets @relationships to the current_user's following relationships" do 
      alice = Fabricate(:user)
      session[:user_id] = alice.id 
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bob, follower: alice)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
  end
end