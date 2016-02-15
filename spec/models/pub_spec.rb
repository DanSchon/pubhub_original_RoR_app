require 'rails_helper'

describe Pub do 
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:url) }
  it { should validate_uniqueness_of(:title) }
  it { should belong_to(:user)}
end