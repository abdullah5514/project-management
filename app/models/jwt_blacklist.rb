class JwtBlacklist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  validates :jti, presence: true, uniqueness: true
end
