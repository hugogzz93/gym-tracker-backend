# frozen_string_literal: true

require 'active_support/concern'

# Usage:
#   class UserOps < GraphQL::Schema::Object
#     include GraphqlMutation
#     is_mutation_of User
#
#     ...any overwrites here
#   end
#
#   or inline
#
#   UserOps = GraphqlMutation.create_ops_for User
module GraphqlMutation
  extend ActiveSupport::Concern

  module MutationHelper
    @create = proc do |_, input, _ctx, model|
      model.create! input
    end

    @update = proc do |instance, input, _ctx, _model|
      instance.update! input
      instance.reload
    end

    @destroy = proc do |instance|
      instance.destroy!
      instance.id
    rescue StandardError
      nil
    end

    def self.create
      @create
    end

    def self.update
      @update
    end

    def self.destroy
      @destroy
    end
  end

  def self.create_ops_for(model)
    Class.new(GraphQL::Schema::Object) do
      include GraphqlMutation
      is_mutation_of model
    end
  end

  included do
    def self.is_mutation_of(model)
      class_eval do
        @model = model

        create = proc do |_, args, _ctx|
          MutationHelper.create.call(_, args[:input].to_h, _ctx, model)
        end

        update = proc do |_, args, _ctx|
          MutationHelper.update.call(_, args[:input].to_h, _ctx, model)
        end

        destroy = proc do |instance|
          MutationHelper.destroy.call(instance)
        end

        field :create, "Types::#{model.name}Type", null: false,
                                                   resolve: create do
          argument :input, "Types::#{model.name}InputType", required: true
        end

        field :update, "Types::#{model.name}Type", null: false,
                                                   resolve: update do
          argument :input, "Types::#{model.name}InputType", required: true
        end

        field :destroy, [GraphQL::Types::ID], null: false, resolve: destroy
      end
    end

    def self.is_batchable
      model = @model
      class_eval do
        batch_create = proc do |_, args, _ctx|
          args[:inputs].map do |input|
            MutationHelper.create.call(_, input.to_h, _ctx, model)
          end
        end

        # batch_update = proc do |_, args, _ctx|
        #   array.map &MutationHelper.update
        # end
        #
        # batch_destroy = proc do |_, args, _ctx|
        # end

        field :batch_create, ["Types::#{model.name}Type"], null: false,
                                                           resolve: batch_create do
          argument :inputs, ["Types::#{model.name}InputType"], required: true
        end

        # field :update, [ "Types::#{model.name}Type" ], null: false,
        #         resolve: batch_update do
        #   argument :inputs, [ "Types::#{model.name}InputType" ], required: true
        # end

        # field :batch_destroy, [ GraphQL::Types::ID ], null: false,
        #     resolve: batch_destroy do
        #   argument :inputs, [ GraphQL::Types::ID ], required: true
        # end
      end
    end
  end
end
