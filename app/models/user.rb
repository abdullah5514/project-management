class User < ApplicationRecord
  enum role: { user: 'User', admin: 'Admin' }

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  validates :name, :email, presence: true
  validates :role, inclusion: { in: %w[Admin User] }

  def jwt_payload
    { role: role }
  end
end
