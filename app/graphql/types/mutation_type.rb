module Types
  class MutationType < Types::BaseObject
    field :nutrient_intake, Mutations::NutrientIntakeOps, null: false do
      argument :id, ID, required: false
    end

    field :intake, Mutations::IntakeOps, null: false do
      argument :id, ID, required: false
    end

    def intake(id: nil)
      id ? Intake.find(id) : Mutations::IntakeOps
    end

    def nutrient_intake(id: nil)
      id ? NutrientIntake.find(id) : Mutations::NutrientIntakeOps
    end
  end
end
