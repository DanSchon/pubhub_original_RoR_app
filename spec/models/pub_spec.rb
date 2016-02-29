require 'rails_helper'

describe Pub do 
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:url) }
  it { should validate_uniqueness_of(:title) }
  it { should belong_to(:user) }
  it { should have_many(:reviews) }

  describe "search_by_title" do
    it "returns an empty array if there is no match" do 
      pub1 = Pub.create(title: "theory of relativity", content: "cool theory", url: "www.google.com")
      pub2 = Pub.create(title: "theory of evolution", content: "we come from monkeys", url: "www.yahoo.com")
      expect(Pub.search_by_title("gravity")).to eq([])
    end
    it "returns an array of one pub for an exact match" do 
      pub1 = Pub.create(title: "theory of relativity", content: "cool theory", url: "www.google.com")
      pub2 = Pub.create(title: "theory of evolution", content: "we come from monkeys", url: "www.yahoo.com")
      expect(Pub.search_by_title("relativity")).to eq([pub1])
    end
    it "returns an array of one video for a partial match" do
      pub1 = Pub.create(title: "theory of relativity", content: "cool theory", url: "www.google.com")
      pub2 = Pub.create(title: "theory of evolution", content: "we come from monkeys", url: "www.yahoo.com")
      expect(Pub.search_by_title("lution")).to eq([pub2])
    end
    it "returns an array of all matches ordered by created_at" do
      pub1 = Pub.create(title: "theory of relativity", content: "cool theory", url: "www.google.com")
      pub2 = Pub.create(title: "theory of evolution", content: "we come from monkeys", url: "www.yahoo.com")
      expect(Pub.search_by_title("theory")).to eq([pub2, pub1])
    end
    it "returns an empty array for a search with an empty string" do
      pub1 = Pub.create(title: "theory of relativity", content: "cool theory", url: "www.google.com")
      pub2 = Pub.create(title: "theory of evolution", content: "we come from monkeys", url: "www.yahoo.com")
      expect(Pub.search_by_title("")).to eq([])
    end
  end
end