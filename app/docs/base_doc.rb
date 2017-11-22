module BaseDoc
  include Apipie::DSL::Concern

  def resource(resource)
    controller_name = resource.to_s.camelize + 'Controller'

    (class << self; self; end).send(:define_method, :superclass) do
      const_get(controller_name)
    end

    Apipie.app.set_resource_id(self, controller_name)

    resource_description do
      formats ['json']
    end
  end

  def doc_for(action_name, &block)
    instance_eval(&block)
    # Create a method stub for docs definition, real one must be defined in a controller
    define_method(action_name) {}
  end
end
