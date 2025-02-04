# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_user!
      before_action :set_project, only: [:create]

      # POST /api/v1/tasks
      def create
        # Only allow task creation for active projects assigned to the current user
        if @project.users.include?(current_user) && @project.active?
          @task = @project.tasks.new(task_params)
          @task.user = current_user

          if @task.save
            render json: @task, status: :created
          else
            render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'You are not assigned to this project or the project is inactive.' }, status: :forbidden
        end
      end

      private

      def set_project
        @project = Project.find(params[:project_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Project not found' }, status: :not_found
      end

      def task_params
        params.require(:task).permit(:name, :description, :start_time, :end_time)
      end
    end
  end
end
