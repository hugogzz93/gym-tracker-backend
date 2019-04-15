module BaseOps
  def self.create_default_mutation(model)
    GraphQL::ObjectType.define do
      name model.name + "Ops"

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

      field :create, "Types::#{model.name}Type",
            resolve: create do
        argument :input, "Types::#{model.name}InputType"
      end

      field :update, "Types::#{model.name}Type",
            resolve: update do
        argument :input, "Types::#{model.name}InputType"
      end

      field :destroy, GraphQL::Types::Boolean, resolve: destroy
    end
  end
end
