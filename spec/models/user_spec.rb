# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  # Associations
  it { should have_and_belong_to_many(:projects) }

  # JWT Methods
  describe '#generate_jwt' do
    let(:user) { create(:user) }

    it 'generates a JWT token' do
      token = user.generate_jwt
      expect(token).to be_a(String)
    end
  end

  describe '#decode_jwt' do
    let(:user) { create(:user) }
    let(:token) { user.generate_jwt }

    it 'decodes the JWT token' do
      decoded_token = user.decode_jwt(token)
      expect(decoded_token['user_id']).to eq(user.id)
    end
  end

  describe '#revoke_jwt' do
    let(:user) { create(:user) }
    let(:token) { user.generate_jwt }

    it 'revokes the JWT token' do
      expect { user.revoke_jwt(token) }.to change { JwtBlacklist.count }.by(1)
    end
  end
end
