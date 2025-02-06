# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  enum role: { user: 'User', admin: 'Admin' }

  validates :name, :email, presence: true

  has_and_belongs_to_many :projects

  def jwt_payload
    {
      user_id: id,
      jti: SecureRandom.uuid,
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
    jti = decoded_token['jti']
    JwtBlacklist.create!(jti: jti, exp: Time.at(exp))
  end
end
