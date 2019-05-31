module Types
  class QueryType < Types::BaseObject
    extend GraphqlRelationHelper
    has_many :intakes
    has_many :users

    field :current_user, Types::UserType, null: true

    def current_user
      context[:current_user]
    end

    def intakes(req)
      if req
        query = req[:query].to_h
        query[:id] = query.delete(:ids) if query.key?(:ids)

        if query[:date_range]
          query[:created_at] = query[:date_range][:start].beginning_of_day..query[:date_range][:end].end_of_day
          query.delete(:date_range)
        end
      end

      Intake.where(query)
    end
  end
end
