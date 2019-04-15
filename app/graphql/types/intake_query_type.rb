module Types
  class IntakeQueryType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :ndbid, ID, required: false
  end
end
