require 'rails_helper'

RSpec.describe "Groups", type: :request do
  describe "GET /groups" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    it 'returns a response with all the groups' do
      create(:group)
      get '/groups', headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(Group.all.to_json)
    end
  end

  describe "GET /group" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    let (:group) { create(:group) }

    it 'returns a response with the specified group' do
      get "/groups/#{group.id}", headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(group.to_json)
    end
  end

  describe "POST /groups" do
    let(:user) { create(:user) }
    let(:token) { auth_token_for_user(user)}

    before do
      group_attributes = attributes_for(:group, user_id: user.id)
      post "/groups", params: group_attributes, headers: { Authorization: "Bearer #{token}" }
    end

    it 'creates a new group' do
      expect(Group.count).to eq(1)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end

  describe "PUT /groups/:id" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    let (:group) { create(:group) }

    before do
      put "/groups/#{group.id}", params: {name: "New Name"}, headers: { Authorization: "Bearer #{token}" }
    end

    it 'updates a group' do
      group.reload
      expect(group.name).to eq("New Name")
    end
  end

  describe "DELETE /groups/:id" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    let (:group) { create(:group) }

    before do
      delete "/groups/#{group.id}", headers: { Authorization: "Bearer #{token}" }
    end

    it 'deletes a group' do
      expect(Group.count).to eq(0)
    end
  end
end
