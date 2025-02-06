# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }

  # Associations
  it { should belong_to(:project) }
  it { should belong_to(:user) }

  # Methods
  describe '#duration_in_hours' do
    let(:task) { create(:task, start_time: DateTime.now, end_time: DateTime.now + 2.hours) }

    it 'calculates the correct duration in hours' do
      expect(task.duration_in_hours).to eq(2)
    end
  end

  describe '#formatted_start_time' do
    let(:task) { create(:task, start_time: DateTime.new(2023, 2, 6, 10, 0, 0)) }

    it 'formats the start time correctly' do
      expect(task.formatted_start_time).to eq('10:00 AM, Feb 06')
    end
  end

  describe '#formatted_end_time' do
    let(:task) { create(:task, end_time: DateTime.new(2023, 2, 6, 12, 0, 0)) }

    it 'formats the end time correctly' do
      expect(task.formatted_end_time).to eq('12:00 PM, Feb 06')
    end
  end
end
