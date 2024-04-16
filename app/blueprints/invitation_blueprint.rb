# frozen_string_literal: true

class InvitationBlueprint < Blueprinter::Base
    identifier :id

    view :long do
        fields :accepted, :group_id
        association :sender, blueprint: UserBlueprint, view: :normal
        association :recipient, blueprint: UserBlueprint, view: :normal
    end
end
