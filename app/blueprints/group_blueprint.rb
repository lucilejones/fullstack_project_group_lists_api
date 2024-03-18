# frozen_string_literal: true

class GroupBlueprint < Blueprinter::Base
    identifier :id

    view :short do
        fields :name
    end

    # TODO add view to show all the users in the group
end
