module Types
  class NutrientIntakeType < Types::BaseObject
    field :id, ID, null: false
    field :nutrient_id, ID, null: false
    field :value, Float, null: false
  end
end
