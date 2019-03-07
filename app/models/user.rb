class User < ActiveRecord::Base
  has_many :Projects
  has_many :Yarns, through: :Projects
  has_many :Brands, through: :Yarns
  has_many :Accessories, through: :Projects

  has_secure_password
end
