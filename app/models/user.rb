class User < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  enum role: { user: 'User', admin: 'Admin' }

  validates :name, :email, presence: true

  def jwt_payload
    {
      user_id: id,
      role: role,
      exp: 24.hours.from_now.to_i
    }
  end

  def generate_jwt
    JWT.encode(
      jwt_payload,
      Rails.application.credentials.devise_jwt_secret_key!,
      'HS256'
    )
  end

  def decode_jwt(token)
    JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
  end

  # Method to revoke JWT
  def revoke_jwt(token)
    decoded_token = decode_jwt(token)
    exp = decoded_token['exp']
    JwtBlacklist.create!(jti: id, exp: Time.at(exp))
  end
end
