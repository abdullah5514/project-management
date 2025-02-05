# frozen_string_literal: true

# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  rescue_from JWT::DecodeError, with: :handle_jwt_error

  before_action :authenticate_user!

  private

  def current_user
    @current_user ||= begin
                        decoded = JwtService.new(request).decode_token
                        User.find(decoded['user_id']) if decoded
                      rescue JWT::DecodeError
                        nil
                      end
  end

  def authenticate_user!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end

  def handle_jwt_error
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end
