class User < ActiveRecord::Base
  has_many :projects
  has_many :yarns, -> { distinct }, through: :projects
  has_many :brands, -> { distinct }, through: :yarns
  has_many :accessories, -> { distinct }, through: :projects
  validates_uniqueness_of :email

  has_secure_password

  def projects_finished
    self.projects.select { |project| project.status == "Finished" }
  end

  def projects_wip
    self.projects.select { |project| project.status == "In Progress" }
  end

  def projects_upcoming
    self.projects.select { |project| project.status == "Upcoming" }
  end

  def stash
    self.projects.detect { |project| project.name == "Stash" }
  end

  def yarns_by_brand
    self.yarns.sort_by { |yarn| yarn.color }.sort_by { |yarn| yarn.brand.name }
  end

  def yarns_sorted
    self.yarns_by_brand.sort_by { |yarn| yarn.brand.material }.sort_by { |yarn| yarn.brand.weight }
  end

  def brands_sorted
    self.brands.sort_by { |brand| brand.name }.sort_by { |brand| brand.material }
  end

  def brand_by_weight(wt)
    self.brands_sorted.select { |brand| brand.weight == wt }
  end

  def brand_yarns(given_brand)
    self.yarns.select { |yarn| yarn.brand == given_brand }
  end

end
