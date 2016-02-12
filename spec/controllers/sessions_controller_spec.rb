require 'rails_helper'

describe SessionsController do 
  describe "POST create" do 
    let(:bob) { Fabricate(:user) }
    context "with valid input" do  
      before do
        post :create, full_name: bob.full_name, password: bob.password
      end
      it "puts the signed in user in the session" do 
        expect(session[:user_id]).to eq(bob.id)
      end
      it "redirects to the home page" do 
        expect(response).to redirect_to home_path
      end
      it "sets notice" do
        expect(flash[:success]).to_not be_empty
      end
    end
    context "with invalid input" do 
      before do
        post :create, full_name: bob.full_name, password: bob.password + 'gibberish'
      end
      it "does not put the user in the session" do 
        expect(session[:user_id]).to be_nil
      end
      it "redirects to sign_in_path" do 
        expect(response).to redirect_to sign_in_path
      end
      it "sets the notice" do
        expect(flash[:error]).to_not be_empty
      end
    end
  end
  describe "GET destroy" do 
    it "redirects to root route" do 
      get :destroy
      expect(response).to redirect_to root_path
    end
    it "removes the signed in user from the session" do 
      session[:user_id] = Fabricate(:user).id 
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end