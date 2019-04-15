module Types
  class UserType < Types::BaseObject
    extend GraphqlRelationHelper
    has_many :intakes

    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
  end
end
