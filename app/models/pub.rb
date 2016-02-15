class Pub < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :content, :url
  validates_uniqueness_of :title
end