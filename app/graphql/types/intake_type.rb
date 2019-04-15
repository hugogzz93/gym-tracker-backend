module Types
  class IntakeType < Types::BaseObject
    extend GraphqlRelationHelper
    belongs_to :user

    field :id, ID, null: false
    field :grams, Integer, null: false
  end
end
