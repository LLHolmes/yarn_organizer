class Project < ActiveRecord::Base
  belongs_to :user
  has_many :yarns
  has_many :brands, -> { distinct }, through: :Yarns
  has_many :accessories

end
