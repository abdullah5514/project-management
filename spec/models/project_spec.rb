# spec/models/project_spec.rb
require 'rails_helper'

RSpec.describe Project, type: :model do
  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:duration) }

  # Associations
  it { should have_many(:tasks) }
  it { should have_and_belong_to_many(:users) }

  # Methods
  describe '#end_date' do
    let(:project) { create(:project, start_date: Date.today, duration: '2 days') }

    it 'calculates the correct end date' do
      expect(project.end_date).to eq(Date.today + 2.days)
    end
  end

  describe '#active?' do
    let(:project) { create(:project, start_date: Date.today, duration: '2 days') }

    it 'returns true if the project is active' do
      expect(project.active?).to be true
    end

    it 'returns false if the project is not active' do
      project.update(start_date: 1.month.ago)
      expect(project.active?).to be false
    end
  end

  describe '.active' do
    let!(:active_project) { create(:project, start_date: Date.today, duration: '2 days') }
    let!(:inactive_project) { create(:project, start_date: 1.month.ago, duration: '2 days') }

    it 'returns only active projects' do
      expect(Project.active).to include(active_project)
      expect(Project.active).not_to include(inactive_project)
    end
  end
end
