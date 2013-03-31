class Image < ActiveRecord::Base
  attr_accessible :sol, :urlList
  validates :urlList, :presence => true, :uniqueness => true
  validates :sol, :presence => true
  belongs_to :album
  has_many :votes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
end
