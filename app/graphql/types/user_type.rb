module Types
  class UserType < Types::BaseObject
    extend GraphqlRelationHelper
    has_many :intakes
    has_many :nutrient_intakes
    has_many :nutrient_intake_goals

    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false

    field :daily_intake, DailyReportType, null: false do
      argument :query, DateRangeType, required: false
    end

    def daily_intake(query: nil)
      if query
        dateRange = query[:start].beginning_of_day..query[:end].end_of_day
        query = { created_at: dateRange }
      end

      report = USDA::Api.report(object.intakes.where(query))
      return {totals: [], hourly: []} unless report

      

      hourly = Array.new.tap do |arr|
        report[:hourly].each do |hour, data|
          arr[hour] = data[:nutrients].keys.map do |n_id|
              {
                nutrient_id: n_id,
                name: find_nutrient_by_id(n_id)[:name],
                unit: find_nutrient_by_id(n_id)[:unit],
                value: data[n_id]
              }
          end
        end
      end

      totals = report[:total]
      nutrient_intakes = object.nutrient_intakes.where(query)
      return {totals: totals, hourly: []} unless nutrient_intakes.any?
      totals.each do |total|
        nutrient = nutrient_intakes.find {|x| x.nutrient_id == total['nutrient_id'] }
        next unless nutrient
        total['value'] += nutrient.value
      end
      return {totals: totals, hourly: hourly}
    end
  end
end
