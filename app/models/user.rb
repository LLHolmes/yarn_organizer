class User < ActiveRecord::Base
  has_many :projects
  has_many :yarns, through: :projects
  has_many :brands, through: :yarns
  has_many :accessories, through: :projects

  has_secure_password

  # Validate uniqueness of user login attribute (username or email)

end
