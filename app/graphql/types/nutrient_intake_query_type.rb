# frozen_string_literal: true

module Types
  class NutrientIntakeQueryType < Types::BaseInputObject
    argument :created_at, DateRangeType, required: false
  end
end
