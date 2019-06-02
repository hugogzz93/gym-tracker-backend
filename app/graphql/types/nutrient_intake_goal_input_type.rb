module Types
  class NutrientIntakeGoalInputType < Types::BaseInputObject
    argument :user_id, ID, required: false
    argument :value, Float, required: false
    argument :nutrient_id, ID, required: false
  end
end
