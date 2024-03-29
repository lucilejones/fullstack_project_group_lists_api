# frozen_string_literal: true

class ItemBlueprint < Blueprinter::Base
    identifier :id

    view :normal do
        fields :name, :brand, :store, :notes, :need_to_purchase, :list_id
    end
end
