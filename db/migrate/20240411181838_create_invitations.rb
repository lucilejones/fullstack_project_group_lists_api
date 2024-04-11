class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :group, null: false, foreign_key: true
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
