class Image < ActiveRecord::Base
  attr_accessible :sol, :url, :score
  validates :url, :presence => true, :uniqueness => true
  validates :sol, :presence => true
  validates :score, :presence => true
  belongs_to :album
end
