class Image < ActiveRecord::Base
  attr_accessible :sol, :url
  validates :url, :presence => true, :uniqueness => true
  validates :sol, :presence => true
  belongs_to :album
  has_many :votes, :dependent => :destroy
end
