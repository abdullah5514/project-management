# app/services/assign_user_service.rb
class AssignUserService
  def initialize(project, user)
    @project = project
    @user = user
  end

  def call
    return { success: false, message: 'User already assigned' } if @project.users.include?(@user)

    @project.users << @user
    { success: true, message: 'User assigned to project successfully' }
  end
end
