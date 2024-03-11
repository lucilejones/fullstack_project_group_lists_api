require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it 'is not valid without a list' do
      item = build(:item, list:nil)
      expect(item).not_to be_valid
    end

    it 'is not valid without a name' do
      item = build(:item, name: nil)
      expect(item).not_to be_valid
    end
  end
end
