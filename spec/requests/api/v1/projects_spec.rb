require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }

  describe 'GET /api/v1/projects' do
    it 'returns a list of active projects' do
      get '/api/v1/projects', headers: { 'Authorization' => "Bearer #{admin.generate_jwt}" }

      expect(response).to have_http_status(:ok)
      expect(json).to be_an(Array)
      expect(json.first['id']).to eq(project.id)
    end
  end

  describe 'POST /api/v1/projects/:id/assign' do
    it 'assigns a user to a project' do
      post "/api/v1/projects/#{project.id}/assign", params: { user_id: user.id },
           headers: { 'Authorization' => "Bearer #{admin.generate_jwt}" }

      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('User assigned to project successfully')
    end

    it 'returns error if user already assigned' do
      project.users << user
      post "/api/v1/projects/#{project.id}/assign", params: { user_id: user.id },
           headers: { 'Authorization' => "Bearer #{admin.generate_jwt}" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['error']).to eq('User already assigned')
    end
  end

  describe 'DELETE /api/v1/projects/:id/unassign' do
    it 'unassigns a user from a project' do
      project.users << user
      delete "/api/v1/projects/#{project.id}/unassign", params: { user_id: user.id },
             headers: { 'Authorization' => "Bearer #{admin.generate_jwt}" }

      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('User unassigned from project successfully')
    end
  end
end
