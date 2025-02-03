# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  rescue_from JWT::DecodeError, with: :handle_jwt_error

  before_action :authenticate_user!

  private

  def current_user
    @current_user ||= begin
                        header = request.headers['Authorization']
                        token = header.split(' ').last if header
                        decoded = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
                        User.find(decoded['user_id'])
                      rescue
                        nil
                      end
  end

  def authenticate_user!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
  end

  private

  def handle_jwt_error
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end