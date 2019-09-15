# frozen_string_literal: true

module Types
  class NutrientType < Types::BaseObject
    field :nutrient_id, String, null: false
    field :name, String, null: false
    field :group, String, null: true
    field :unit, String, null: false
    field :value, Float, null: false
  end
end
