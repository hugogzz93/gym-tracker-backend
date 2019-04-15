module Types
  class IntakeInputType < Types::BaseInputObject
    argument :ndbid, ID, required: false
    argument :user_id, ID, required: false
    argument :grams, Integer, required: false
  end
end
