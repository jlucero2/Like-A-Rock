class Vote < ActiveRecord::Base
  validates :image, :presence => true
  #validates :user, :presence => true
  belongs_to :image, :counter_cache => true
  belongs_to :user
end
