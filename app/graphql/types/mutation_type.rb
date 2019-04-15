module Types
  class MutationType < Types::BaseObject

    field :intake, Mutations::IntakeOps, null: false do
      argument :id, ID, required: false
    end

    def intake(id: nil)
      id ? Intake.find(id) : Mutations::IntakeOps
    end
  end
end
