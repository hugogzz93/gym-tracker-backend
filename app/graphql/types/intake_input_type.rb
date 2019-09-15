# frozen_string_literal: true

module Types
  class IntakeInputType < Types::BaseInputObject
    argument :ndbid, ID, required: false
    argument :user_id, ID, required: false
    argument :grams, Integer, required: false
    argument :name, String, required: true
  end
end
