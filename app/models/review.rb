class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :pub

  validates_presence_of :body
end