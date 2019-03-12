class User < ActiveRecord::Base
  has_many :projects
  has_many :yarns, through: :projects
  has_many :brands, through: :yarns
  has_many :accessories, through: :projects

  has_secure_password

  # Validate uniqueness of user login attribute (username or email)

  def projects_finished
    self.projects.select { |project| project if project.status == "Finished" }
  end

  def projects_wip
    self.projects.select { |project| project if project.status == "In Progress" }
  end

  def projects_upcoming
    self.projects.select { |project| project if project.status == "Upcoming" }
  end

end
