module Types
  class DateRangeType < Types::BaseInputObject
    argument :start, GraphQL::Types::ISO8601DateTime, required: true
    argument :end, GraphQL::Types::ISO8601DateTime, required: true
  end
end
