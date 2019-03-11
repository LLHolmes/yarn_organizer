class Yarn < ActiveRecord::Base
  belongs_to :project
  belongs_to :brand
end
