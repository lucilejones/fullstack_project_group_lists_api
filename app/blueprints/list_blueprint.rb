# frozen_string_literal: true

class ListBlueprint < Blueprinter::Base
    identifier :id

    view :short do
        fields :name
    end

    view :long do
        fields :name
        association :items, blueprint: ItemBlueprint, view: :normal do | list, options |
            list.items
        end
    end
end
