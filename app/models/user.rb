class User < ActiveRecord::Base
  has_many :projects
  has_many :yarns, through: :projects
  has_many :brands, through: :yarns
  has_many :accessories, through: :projects

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

end
