require 'rails_helper'

RSpec.describe List, type: :model do
    context "validations" do
        it 'is not valid without a user' do
          list = build(:list, user:nil)
          expect(list).not_to be_valid
        end
    
        it 'is not valid without a name' do
          list = build(:list, name: nil)
          expect(list).not_to be_valid
        end
    end

    context "associations" do
        it 'belongs to a user' do
            list = build(:list)
            expect(list.user).to be_present
        end

        it 'has many items' do
            list = create(:list)
            create_list(:item, 2, list: list)

            list.reload
            expect(list.items.count).to eq(2)
        end
    end
end