# frozen_string_literal: true

class ItemBlueprint < Blueprinter::Base
    identifier :id

    view :normal do
        fields :name, :brand, :store, :notes, :need_to_purchase
    end
end


# t.string "name"
# t.string "brand"
# t.string "store"
# t.text "notes"
# t.boolean "need_to_purchase", default: false