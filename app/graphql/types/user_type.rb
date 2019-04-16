module Types
  class UserType < Types::BaseObject
    extend GraphqlRelationHelper
    has_many :intakes

    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :total_intake, [ NutrientType ], null: false

    def total_intake
      return [] unless object.intakes.any?
      USDA::Api.report(intakes.map(&:ndbid))[:total]
    end
  end
end
