class Vote < ActiveRecord::Base
  validates :image, :presence => true
  validates :user, :presence => true
  belongs_to :image
  belongs_to :user
end
