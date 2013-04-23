class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :image, :presence => true
  attr_accessible :x, :y, :name
end
