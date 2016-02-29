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
  describe "GET new" do 
    it "sets @pub" do 
      get :new
      expect(assigns(:pub)).to be_instance_of(Pub)
    end
  end
  describe "POST create" do
    context "with valid input" do 
      it "redirects to home page" do 
        post :create, pub: Fabricate.attributes_for(:pub)
        expect(response).to redirect_to home_path
      end
      it "creates a pub" do 
        post :create, pub: Fabricate.attributes_for(:pub)
        expect(Pub.count).to eq(1)
      end
      it "creates a pub associated with the current_user" do 
        user = Fabricate(:user)
        session[:user_id] = user.id 
        post :create, pub: Fabricate.attributes_for(:pub), user_id: user.id
        expect(Pub.first.user).to eq(user)
      end
    end
    context "with invalid input" do 
      it "does not create a pub" do
        post :create, pub: {title: "title"}
        expect(Pub.count).to eq(0)
      end
      it "renders new template" do
        post :create, pub: {title: "title"}
        expect(response).to render_template :new
      end
      it "sets notice" do 
        post :create, pub: {title: "title"}
        expect(flash[:error]).to_not be_empty
      end
    end
  end
  describe "GET show" do 
    it "sets @pub" do 
      pub = Fabricate(:pub)
      get :show, id: pub.id
      expect(assigns(:pub)).to eq(pub)
    end
    it "sets @review" do 
      pub = Fabricate(:pub)
      get :show, id: pub.id
      expect(assigns(:review)).to be_instance_of(Review)
    end
  end
  describe "POST search" do
    it "sets @results for authenticated users" do 
      session[:user_id] = Fabricate(:user).id 
      pub = Fabricate(:pub, title: "evolution")
      post :search, search_term: "evolution"
      expect(assigns(:results)).to eq([pub])
    end
  end
end