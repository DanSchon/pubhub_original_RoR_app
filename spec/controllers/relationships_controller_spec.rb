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
  describe "POST create" do 
    it "creates a relationship where the current_user follows the leader" do 
      alice = Fabricate(:user)
      session[:user_id] = alice.id 
      bob = Fabricate(:user)
      post :create, leader_id: bob.id 
      expect(alice.following_relationships.first.leader).to eq(bob)
    end
    it "redirects to the following page" do 
      alice = Fabricate(:user)
      session[:user_id] = alice.id 
      bob = Fabricate(:user)
      post :create, leader_id: bob.id 
      expect(response).to redirect_to following_path
    end
    it "does not create a relationship if the current_user already follows the leader" do 
      alice = Fabricate(:user)
      session[:user_id] = alice.id 
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bob, follower: alice)
      post :create, leader_id: bob.id 
      expect(Relationship.count).to eq(1)
    end
    it "does not allow the current_user to follow himself" do 
      alice = Fabricate(:user)
      session[:user_id] = alice.id 
      post :create, leader_id: alice.id 
      expect(Relationship.count).to eq(0)
    end
  end
end