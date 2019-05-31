module Mutations
  class NutrientIntakeOps < GraphQL::Schema::Object
    include GraphqlMutation
    is_mutation_of NutrientIntake
    is_batchable
    # field :create, Types::NutrientIntakeType, null: false do
    #   argument :input, Types::NutrientIntakeInputType, required: true
    # end
    #
    # field :batch_create, [ Types::NutrientIntakeType ], null: false do
    #   argument :inputs, [ Types::NutrientIntakeInputType ], required: true
    # end
    #
    # def create(input:)
    #   NutrientIntake.create input.to_h.merge(user: User.first)
    # end
    #
    # def batch_create(inputs:)
    #   inputs.map { |input| NutrientIntake.create input.to_h }
    # end

  end
end
