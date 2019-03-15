class Brand < ActiveRecord::Base
  has_many :yarns

  def yarns_by_color
    self.yarns.sort_by { |yarn| yarn.color }
  end
end
