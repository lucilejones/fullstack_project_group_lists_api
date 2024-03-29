# frozen_string_literal: true

class GroupBlueprint < Blueprinter::Base
    identifier :id

    view :short do
        fields :name
    end

    # TODO add view to show all the users in the group
    view :long do
        fields :name
        association :members, blueprint: UserBlueprint, view: :normal do | group, options |
            group.members
        end
    end
end
