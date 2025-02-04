class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def assigned_projects
    projects = current_user.projects.includes(:tasks).where('start_date <= ?', Date.current)
    active_projects = projects.select { |project| project.end_date >= Date.current }

    render json: active_projects, status: :ok
  end
end
