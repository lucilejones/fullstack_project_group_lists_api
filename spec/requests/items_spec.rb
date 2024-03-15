require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET /items" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    it 'returns a response with all the items' do
      create(:item)
      get '/items', headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(Item.all.to_json)
    end
  end

  describe "GET /item" do
    let (:item) {create(:item)}

    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    it 'returns a response with the specified item' do
      get "/items/#{item.id}", headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(item.to_json)
    end
  end

  describe "POST /items" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    let(:list) {create(:list)}

    before do
      item_attributes = attributes_for(:item, list_id: list.id)
      post "/items", params: item_attributes, headers: { Authorization: "Bearer #{token}" }
    end

    it 'creates a new item' do
      expect(Item.count).to eq(1)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end

  describe "PUT /items/:id" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    let (:item) {create(:item)}

    before do
      put "/items/#{item.id}", params: {name: "new name"}, headers: { Authorization: "Bearer #{token}" }
    end

    it 'updates an item' do
      item.reload
      expect(item.name).to eq("new name")
    end
  end

  describe "DELETE /items/:id" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user)}

    let (:item) {create(:item)}

    before do
      delete "/items/#{item.id}", headers: { Authorization: "Bearer #{token}" }
    end

    it 'deletes an item' do
      expect(Item.count).to eq(0)
    end
  end
end
