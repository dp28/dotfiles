module SpecifiesInput
  class UnspecifiedInputError < StandardError
    def initialize(name)
      super("No iput value was specified for '#{name}'")
    end
  end

  class InputSpecification
    attr_reader :name, :context, :description

    def initialize(name:, description:, context: nil, type: :string)
      @name = name
      @context = context
      @description = description
      @type = type
    end
  end

  module ClassMethods
    def uses_input(name, **kwargs)
      class_variable_get(:@@input_specifications)[name] = InputSpecification.new(name: name, **kwargs)
    end
  end

  def self.included(host_class)
    @@input_specifications = {}

    host_class.extend(ClassMethods)
  end

  def input_value_for(name)
    specification = @@input_specifications[name]
    raise UnspecifiedInputError.new(name) unless specification

    @dependencies.fetch(:fetch_input).call(specification)
  end
end
