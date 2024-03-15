require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'Validations' do
    it 'is not valid without a user' do
      group = build(:group, user:nil)
      expect(group).not_to be_valid
    end

    it 'is not valid without a name' do
      group = build(:group, name: nil)
      expect(group).not_to be_valid
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      group = build(:group)
      expect(group.user).to be_present
    end
  end

  # add a context for destroys related associations? 
  # it 'destroys group users'?
end
