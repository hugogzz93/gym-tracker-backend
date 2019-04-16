module Types
  class UserQueryType < Types::BaseInputObject
    argument :id, ID, required: false
  end
end
