class Response < ActiveRecord::Base
  belongs_to :image
  belongs_to :admin
  attr_accessible :body

  validates :body, :presence => true
end
