# frozen_string_literal: true

# app/controllers/api/v1/projects_controller.rb
module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_user!
      before_action :authenticate_admin, only: %i[assign unassign]
      before_action :set_project, only: %i[assign unassign task_breakdown]

      # GET /api/v1/projects/active
      def index
        projects = Project.includes(:tasks).where('start_date <= ?', Date.current)
        active_projects = projects.select { |project| project.end_date >= Date.current }

        render json: active_projects
      end

      # POST /api/v1/projects/:id/assign
      def assign
        user = User.find(params[:user_id])

        if @project.users.include?(user)
          render json: { error: 'User already assigned' }, status: :unprocessable_entity
        else
          @project.users << user
          render json: { message: 'User assigned to project successfully' }, status: :ok
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      # DELETE /api/v1/projects/:id/unassign
      def unassign
        user = User.find(params[:user_id])

        if @project.users.include?(user) # Check if the user is assigned to the project
          @project.users.delete(user)
          render json: { message: 'User unassigned from project successfully' }, status: :ok
        else
          render json: { error: 'Assignment not found' }, status: :not_found
        end
      end

      # GET /api/v1/projects/:id/task_breakdown
      def task_breakdown
        tasks = @project.tasks.order(:start_time)
        assigned_users = @project.users
        available_users = User.where.not(id: assigned_users.ids)

        breakdown = tasks.map do |task|
          {
            name: task.name,
            duration: "#{task.duration_in_hours} hours",
            time_range: "#{task.formatted_start_time} - #{task.formatted_end_time}",
            date: task.start_time.to_date.to_s
          }
        end

        total_hours = tasks.sum(&:duration_in_hours)

        render json: {
          project: @project.name,
          tasks: breakdown,
          total_hours: "#{total_hours} hours",
          assigned_users: assigned_users.map { |user| { id: user.id, name: user.name } },
          available_users: available_users.map { |user| { id: user.id, name: user.name } }
        }
      end

      private

      def set_project
        @project = Project.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Project not found' }, status: :not_found
      end

      def authenticate_admin
        return if current_user.admin?

        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
