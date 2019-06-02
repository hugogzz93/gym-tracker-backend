module Types
  class MutationType < Types::BaseObject
    IntakeGoalOps = GraphqlMutation.create_ops_for NutrientIntakeGoal
    field :nutrient_intake, Mutations::NutrientIntakeOps, null: false do
      argument :id, ID, required: false
    end

    field :intake, Mutations::IntakeOps, null: false do
      argument :id, ID, required: false
    end

    field :nutrient_intake_goal, IntakeGoalOps, null: false do
      argument :id, ID, required: false
      argument :nutrient_id, ID, required: false
    end

    def intake(id: nil)
      id ? Intake.find(id) : Mutations::IntakeOps
    end

    def nutrient_intake(id: nil)
      id ? NutrientIntake.find(id) : Mutations::NutrientIntakeOps
    end

    def nutrient_intake_goal(id: nil, nutrient_id: nil)
      if(id)
        NutrientIntakeGoal.find(id)
      elsif(nutrient_id)
        User.first.nutrient_intake_goals.find_by(nutrient_id: nutrient_id)
      else
        NutrientIntakeOps
      end
    end

  end
end
