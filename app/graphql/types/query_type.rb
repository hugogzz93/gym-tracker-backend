module Types
  class QueryType < Types::BaseObject
    extend GraphqlRelationHelper

    has_many :intakes

    field :current_user, Types::UserType, null: true

    def current_user
      context[:current_user]
    end
  end
end
