module Types
  class UserType < Types::BaseObject
    extend GraphqlRelationHelper
    has_many :intakes
    has_many :nutrient_intakes

    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false

    field :total_intake, [ NutrientType ], null: false do
      argument :query, DateRangeType, required: false
    end

    def total_intake(query: nil)
      if query
        dateRange = query[:start].beginning_of_day..query[:end].end_of_day
        query = { created_at: dateRange }
      end

      intakes = object.intakes.where(query)
      totals = intakes.any? ? USDA::Api.report(intakes)[:total] : []

      n_intakes = object.nutrient_intakes.where(query)
      return totals unless n_intakes.any?
      totals.each do |total|
        nutrient = n_intakes.find {|x| x.nutrient_id == total['nutrient_id'] }
        next unless nutrient
        total['value'] += nutrient.value
      end
      return totals
    end
  end
end
