require 'rails_helper' 

describe User do
  it { should validate_presence_of(:full_name)}
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}
  it { should validate_uniqueness_of(:email)}
  it { should have_many(:pubs) }
  it { should have_many(:reviews) }

  describe "#already_follows?" do 
    it "returns true if the user has a following relationship with a leader" do 
      bob = Fabricate(:user)
      alice = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.already_follows?(bob)).to be_truthy
    end
    it "returns false if the user does not have a following relationship with a leader" do 
      bob = Fabricate(:user)
      alice = Fabricate(:user)
      Fabricate(:relationship, leader: alice, follower: bob)
      expect(alice.already_follows?(bob)).to be_falsey
    end
  end
end