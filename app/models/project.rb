class Project < ActiveRecord::Base
  belongs_to :user
  has_many :yarns
  has_many :brands, through: :Yarns
  has_many :accessories

  def self.status_finished(id)
    self.all.map { |project| project.user_id == id && project.status == "Finished" }
  end

  def self.status_wip(id)
    self.all.map { |project| project.user_id == id && project.status == "In Progress" }
  end

  def self.status_upcoming(id)
    self.all.map { |project| project.user_id == id && project.status == "Upcoming" }
  end

end
