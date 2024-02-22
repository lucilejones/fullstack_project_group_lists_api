class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :list, null: false, foreign_key: true
      t.string :name
      t.string :brand
      t.string :store
      t.text :notes
      t.boolean :need_to_purchase, default: false

      t.timestamps
    end
  end
end
