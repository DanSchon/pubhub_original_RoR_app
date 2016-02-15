require 'rails_helper'

describe Review do 
  it { should belong_to(:user) }
  it { should belong_to(:pub) }
  it { should validate_presence_of(:body)}
end