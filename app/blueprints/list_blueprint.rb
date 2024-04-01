# frozen_string_literal: true

class ListBlueprint < Blueprinter::Base
    identifier :id

    view :short do
        fields :name, :user_id
    end

    view :long do
        fields :name, :user_id
        association :items, blueprint: ItemBlueprint, view: :normal do | list, options |
            list.items
        end
        association :user, blueprint: UserBlueprint, view: :normal
    end
end
