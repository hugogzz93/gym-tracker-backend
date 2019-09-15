# frozen_string_literal: true

module Types
  class NutrientIntakeGoalQueryType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :nutrient_id, ID, required: false
  end
end
