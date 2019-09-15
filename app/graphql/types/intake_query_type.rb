# frozen_string_literal: true

module Types
  class IntakeQueryType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :ndbid, ID, required: false
    argument :date_range, DateRangeType, required: false
  end
end
