# frozen_string_literal: true

module Types
  class DailyReportType < Types::BaseObject
    field :totals, [NutrientType], null: false
    field :hourly, [[NutrientType]], null: true
  end
end
