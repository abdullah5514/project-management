# app/controllers/concerns/authentication.rb
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :authenticate_admin, only: %i[index assign unassign]
  end

  private

  def authenticate_admin
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.admin?
  end
end
