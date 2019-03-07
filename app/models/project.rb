class Project < ActiveRecord::Base
  belongs_to :User
  has_many :Yarns
  has_many :Brands, through: :Yarns
  has_many :Accessories
end
