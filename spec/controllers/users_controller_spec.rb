require 'rails_helper'

describe UsersController do 
  describe "GET new" do 
    it "sets @user" do 
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe "POST create" do 
    context "with valid inputs" do 
      before do 
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "creates a user" do 
        expect(User.count).to eq(1)
      end
      it "redirects to the home page" do 
        expect(response).to redirect_to sign_in_path
      end
      it "sets notice" do
        expect(flash[:success]).to_not be_empty
      end
    end
    context "with invalid input" do 
      before do 
        post :create, user: { full_name: "Daniel Shonfeld"}
      end
      it "does not create a user" do 
        expect(User.count).to eq(0)
      end
      it "sets @user" do 
        expect(assigns(:user)).to be_instance_of(User)
      end
      it "renders the new template" do 
        expect(response).to render_template :new
      end
      it "sets notice" do 
        expect(flash[:error]).to_not be_empty
      end
    end
    context "sending emails" do
      after { ActionMailer::Base.deliveries.clear }
      it "sends out email to the user with valid inputs" do
        post :create, user: { email: "john@email.com", password: "password", full_name: "John Smith"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(['john@email.com'])
      end
      it "sends out email containing the user's name with valid inputs" do
        post :create, user: { email: "john@email.com", password: "password", full_name: "John Smith"}
        expect(ActionMailer::Base.deliveries.last.body).to include("PubHub")
      end
      it "does not send out email with invalid inputs" do
        post :create, user: { email: "john@email.com"}
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
  describe "GET show" do 
    it "sets @user" do 
      alice = Fabricate(:user)
      get :show, id: alice.id 
      expect(assigns(:user)).to eq(alice)
    end
  end
end