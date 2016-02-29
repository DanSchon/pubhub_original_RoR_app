class Pub < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  validates_presence_of :title, :content, :url
  validates_uniqueness_of :title

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title ILIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end