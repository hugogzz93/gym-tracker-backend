# frozen_string_literal: true

class GymTrackerBackendSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
