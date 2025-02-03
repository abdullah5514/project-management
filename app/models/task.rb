class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :name, :start_time, :end_time, presence: true

  def duration_in_hours
    ((end_time - start_time) / 1.hour).round
  end
end
