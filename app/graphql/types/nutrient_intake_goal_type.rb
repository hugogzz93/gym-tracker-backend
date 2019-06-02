module Types
  class NutrientIntakeGoalType < Types::BaseObject
    extend GraphqlRelationHelper
    belongs_to :user

    field :id, ID, null: false
    field :nutrient_id, ID, null: false
    field :value, Float, null: false
  end
end
