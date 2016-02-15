require 'rails_helper'

describe ReviewsController do 
  describe "POST create" do 
    context "with valid input" do 
      it "redirects to the pubs show page" do 
        pub = Fabricate(:pub)
        post :create, review: Fabricate.attributes_for(:review), pub_id: pub.id 
        expect(response).to redirect_to pub
      end
      it "creates a review" do 
        pub = Fabricate(:pub)
        post :create, review: Fabricate.attributes_for(:review), pub_id: pub.id 
        expect(Review.count).to eq(1)
      end
      it "creates a review associated with the pub" do
        pub = Fabricate(:pub)
        post :create, review: Fabricate.attributes_for(:review), pub_id: pub.id 
        expect(Review.first.pub).to eq(pub)
      end
      it "creates a review associated with the current_user" do 
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        pub = Fabricate(:pub)
        post :create, review: Fabricate.attributes_for(:review), pub_id: pub.id 
        expect(Review.first.user).to eq(current_user)
      end
    end
    context "with invalid input" do 
      it "sets @pub" do 
        pub = Fabricate(:pub)
        post :create, review: { body: nil }, pub_id: pub.id 
        expect(assigns(:pub)).to eq(pub)
      end
      it "sets @reviews" do 
        pub = Fabricate(:pub)
        past_review = Fabricate(:review, pub: pub)
        post :create, review: { body: nil }, pub_id: pub.id
        expect(assigns(:reviews)).to match_array([past_review])
      end 
      it "renders the pubs/show page" do 
        pub = Fabricate(:pub)
        post :create, review: { body: nil }, pub_id: pub.id 
        expect(response).to render_template "pubs/show"
      end
      it "does not create a review" do 
        pub = Fabricate(:pub)
        post :create, review: { body: nil }, pub_id: pub.id
        expect(Review.count).to eq(0)
      end
    end
  end
end