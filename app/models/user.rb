class User < ActiveRecord::Base
  has_many :pubs
  has_many :reviews
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id  
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_secure_password validations: false

  def already_follows?(leader)
    following_relationships.map(&:leader).include?(leader)
  end
end