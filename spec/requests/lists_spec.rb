require 'rails_helper'

RSpec.describe "Lists", type: :request do
  describe "GET /lists" do
    let(:list) {create(:list)}

    before do
      list
      get "/lists"
    end

    it "returns a successful response" do
      expect(response).to be_successful
    end

    it "returns a response with all the lists" do
      expect(response.body).to eq(List.all.to_json)
    end
  end

  describe "GET /lists/:id" do
    let(:list) {create(:list)}

    before do
      get "/lists/#{list.id}"
    end

    it "returns a successful response" do
      expect(response).to be_successful
    end

    it "returns a response with the correct list" do
      expect(response.body).to eq(list.to_json)
    end
  end

  describe "POST /lists" do
    context "with valid params" do
      let (:user) {create(:user)}

      before do
        list_attributes = attributes_for(:list, user_id: user.id)
        post "/lists", params: list_attributes
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "creates a new list" do
        expect(List.count).to eq(1)
      end
    end

    context "with invalid params" do

      before do
        list_attributes = attributes_for(:list, user_id: nil)
        post "/lists", params: list_attributes
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /lists/:id" do
    context "with valid params" do
      let(:list) {create(:list)}

      before do
        list_attributes = attributes_for(:list, name: "updated name")
        put "/lists/#{list.id}", params: list_attributes
      end

      it "updates a list" do
        list.reload
        expect(list.name).to eq("updated name")
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      let(:list) {create(:list)}

      before do
        list_attributes = {name: nil}
        put "/lists/#{list.id}", params: list_attributes
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /lists/:id" do
    let(:list) {create(:list)}

    before do
      delete "/lists/#{list.id}"
    end

    it "deletes a list" do
      expect(List.count).to eq(0)
    end

    it "returns a successful response" do
      expect(response).to be_successful
    end
  end

end
