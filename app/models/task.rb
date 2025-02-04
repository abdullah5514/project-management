# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :name, :start_time, :end_time, presence: true

  def duration_in_hours
    ((end_time - start_time) / 1.hour).round
  end

  def formatted_start_time
    start_time.strftime('%I:%M %p, %b %d')
  end

  def formatted_end_time
    end_time.strftime('%I:%M %p, %b %d')
  end
end
