class Project < ApplicationRecord

  validates :name, :start_date, :duration, presence: true

  has_many :tasks
  has_and_belongs_to_many :users

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
