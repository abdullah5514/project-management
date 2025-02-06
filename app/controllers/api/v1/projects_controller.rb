# frozen_string_literal: true

# app/controllers/api/v1/projects_controller.rb
module Api
  module V1
    class ProjectsController < ApplicationController
      include Authentication

      before_action :set_project, only: %i[assign unassign task_breakdown]

      # GET /api/v1/projects/active
      def index
        projects = Project.includes(:tasks).where('start_date <= ?', Date.current)
        active_projects = projects.select { |project| project.end_date >= Date.current }
        render json: active_projects
      end

      # POST /api/v1/projects/:id/assign
      def assign
        user = find_user_by_id
        service = AssignUserService.new(@project, user)

        result = service.call
        render_result(result)
      end

      # DELETE /api/v1/projects/:id/unassign
      def unassign
        user = find_user_by_id
        service = UnassignUserService.new(@project, user)

        result = service.call
        render_result(result)
      end

      # GET /api/v1/projects/:id/task_breakdown
      def task_breakdown
        service = TaskBreakdownService.new(@project)
        result = service.call

        render json: result
      end

      private

      def set_project
        @project = Project.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Project not found' }, status: :not_found
      end

      def find_user_by_id
        User.find_by(id: params[:user_id])
      end

      def render_result(result)
        if result[:success]
          render json: { message: result[:message] }, status: :ok
        else
          render json: { error: result[:message] }, status: :unprocessable_entity
        end
      end
    end
  end
end
