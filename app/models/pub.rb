class Pub < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  validates_presence_of :title, :content, :url
  validates_uniqueness_of :title
end