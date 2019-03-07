class Yarn < ActiveRecord::Base
  belongs_to :Project
  belongs_to :Brand
end
