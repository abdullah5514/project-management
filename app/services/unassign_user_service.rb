# app/services/unassign_user_service.rb
class UnassignUserService
  def initialize(project, user)
    @project = project
    @user = user
  end

  def call
    return { success: false, message: 'Assignment not found' } unless @project.users.include?(@user)

    @project.users.delete(@user)
    { success: true, message: 'User unassigned from project successfully' }
  end
end
