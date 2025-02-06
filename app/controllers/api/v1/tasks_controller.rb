# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_user!
      before_action :set_project, only: [:create]

      # POST /api/v1/tasks
      def create
        service = CreateTaskService.new(@project, current_user, task_params)
        result = service.call

        if result[:success]
          render json: result[:task], status: :created
        else
          render json: { error: result[:message] }, status: result[:message].include?('inactive') ? :forbidden : :unprocessable_entity
        end
      end

      private

      def set_project
        @project = Project.find_by(id: params[:project_id])
        render json: { error: 'Project not found' }, status: :not_found unless @project
      end

      def task_params
        params.require(:task).permit(:name, :description, :start_time, :end_time)
      end
    end
  end
end
