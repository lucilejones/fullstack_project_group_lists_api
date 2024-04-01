# frozen_string_literal: true

class GroupBlueprint < Blueprinter::Base
    identifier :id

    view :short do
        fields :name
    end

    # TODO add view to show all the users in the group
    view :long do
        fields :name
        association :creator, blueprint: UserBlueprint, view: :normal
        association :members, blueprint: UserBlueprint, view: :normal do | group, options |
            group.members
        end
        association :lists, blueprint: ListBlueprint, view: :long do | group, options |
            group.lists
        end
    end
end
