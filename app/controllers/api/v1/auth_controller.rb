# frozen_string_literal: true

# app/controllers/api/v1/auth_controller.rb
module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user!, only: [:create]

      def create
        user = User.find_by!(email: params[:email]) # Raise exception if not found

        if user.valid_password?(params[:password])
          render json: {
            user: user.as_json(only: %i[id email role]),
            token: user.generate_jwt
          }
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      def destroy
        token = extract_token_from_header
        current_user.revoke_jwt(token)
        head :no_content
      end

      private

      def extract_token_from_header
        header = request.headers['Authorization']
        header.split(' ').last if header.present?
      end
    end
  end
end
