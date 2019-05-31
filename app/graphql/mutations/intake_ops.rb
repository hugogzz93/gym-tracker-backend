module Mutations
  class IntakeOps < GraphQL::Schema::Object
    include GraphqlMutation
    is_mutation_of Intake
    is_batchable

    # field :create, Types::IntakeType, null: false do
    #   argument :input, Types::IntakeInputType, required: true
    # end

    # def create(input:)
    #   #TODO: use context[:current_user]
    #   # Intake.create! input.to_h.merge({user: User.find_by({email: 'pinelo93@gmail.com'})})
    # end

  end
end
