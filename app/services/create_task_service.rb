# app/services/create_task_service.rb
class CreateTaskService
  def initialize(project, current_user, task_params)
    @project = project
    @current_user = current_user
    @task_params = task_params
  end

  def call
    return { success: false, message: 'You are not assigned to this project or the project is inactive.' } unless valid_project?

    @task = @project.tasks.new(@task_params)
    @task.user = @current_user

    if @task.save
      { success: true, task: @task }
    else
      { success: false, message: @task.errors.full_messages }
    end
  end

  private

  def valid_project?
    @project.users.include?(@current_user) && @project.active?
  end
end
