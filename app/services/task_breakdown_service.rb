# app/services/task_breakdown_service.rb
class TaskBreakdownService
  def initialize(project)
    @project = project
  end

  def call
    breakdown = @project.tasks.order(:start_time).map do |task|
      {
        name: task.name,
        duration: "#{task.duration_in_hours} hours",
        time_range: "#{task.formatted_start_time} - #{task.formatted_end_time}",
        date: task.start_time.to_date.to_s
      }
    end

    total_hours = @project.tasks.sum(&:duration_in_hours)

    {
      project_name: @project.name,
      tasks: breakdown,
      total_hours: "#{total_hours} hours",
      assigned_users: assigned_users,
      available_users: available_users
    }
  end

  private

  def assigned_users
    @project.users.map { |user| { id: user.id, name: user.name } }
  end

  def available_users
    User.where.not(id: @project.users.ids).map { |user| { id: user.id, name: user.name } }
  end
end
