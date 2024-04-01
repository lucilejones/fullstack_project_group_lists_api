class AddGroupToLists < ActiveRecord::Migration[7.1]
  def change
    add_reference :lists, :group, null: true, foreign_key: true
  end
end
