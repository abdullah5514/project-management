# app/controllers/api/v1/auth_controller.rb
class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      render json: {
        user: user.as_json(only: [:id, :email, :role]),
        token: user.generate_jwt
      }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def destroy
    header = request.headers['Authorization']
    token = header.split(' ').last
    current_user.revoke_jwt(token)
    head :no_content
  end
end