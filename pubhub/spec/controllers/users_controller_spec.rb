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
  end
end