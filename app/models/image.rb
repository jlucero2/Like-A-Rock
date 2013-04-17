class Image < ActiveRecord::Base
  attr_accessible :sol, :urlList, :responded_at, :commented_at
  validates :urlList, :presence => true, :uniqueness => true
  validates :sol, :presence => true
  belongs_to :album
  has_many :votes, :dependent => :destroy
  has_many :responses, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :tags, :dependent => :destroy
end
