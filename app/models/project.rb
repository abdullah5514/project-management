class Project < ApplicationRecord
  has_many :tasks
  validates :name, :start_date, :duration, presence: true

  def end_date
    duration = self.duration.split(' ')
    start_date + duration[0].to_i.send(duration[1])
  end

  def active?
    Date.current.between?(start_date, end_date)
  end

  def self.active
    all.select(&:active?)
  end
end
