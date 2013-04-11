class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :ip, :email, :password, :password_confirmation, :remember_me
  #attr_accessible :email, :name, :password

  validates :name,  :presence => true
  validates :email, :presence => true
  #validates :ip,  :presence => true
  validates :password, :presence => true

  has_many :comments
  has_many :votes
  has_many :tags
end
