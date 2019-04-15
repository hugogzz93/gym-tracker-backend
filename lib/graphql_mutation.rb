require 'active_support/concern'

# Usage:
#   class UserOps < GraphQL::Schema::Object
#     include GraphqlMutation
#     is_mutation_of User
#
#     ...any averwrites here
#   end
#
#   or inline
#
#   UserOps = GraphqlMutation.create_ops_for User
module GraphqlMutation
  extend ActiveSupport::Concern
  def self.create_ops_for(model)
    Class.new(GraphQL::Schema::Object) do
      include GraphqlMutation
      is_mutation_of model
    end
  end

  included do
    def self.is_mutation_of(model)

      self.class_eval do
        create = proc do |_, args, _ctx|
          model.create! args.input.to_h
        end

        update = proc do |instance, args, _ctx|
          instance.update! args.input.to_h
          instance.reload
        end

        destroy = proc do |instance|
          instance.destroy!
        end


        field :create, "Types::#{model.name}Type", null: false,
              resolve: create do
          argument :input, "Types::#{model.name}InputType", required: true
        end

        field :update, "Types::#{model.name}Type", null: false,
              resolve: update do
          argument :input, "Types::#{model.name}InputType", required: true
        end

        field :destroy, GraphQL::Types::Boolean, null: false, resolve: destroy
      end
    end
  end
end
