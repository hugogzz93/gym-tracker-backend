module Types
  class NutrientIntakeInputType < Types::BaseInputObject
    argument :nutrient_id, ID, required: false
    argument :value, Float, required: false
    argument :user_id, ID, required: false
  end
end
