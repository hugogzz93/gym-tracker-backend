# frozen_string_literal: true

module Types
  class IntakeType < Types::BaseObject
    extend GraphqlRelationHelper
    belongs_to :user

    field :id, ID, null: false
    field :ndbid, String, null: false
    field :name, String, null: false
    field :grams, Integer, null: false
    # field :nutrients, [ NutrientType ], null: false
  end
end
