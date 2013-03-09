class Tag < ActiveRecord::Base
  belongs_to :user
  belongs_to :image
  attr_accessible :coords
end
