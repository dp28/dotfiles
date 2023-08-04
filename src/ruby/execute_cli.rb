require_relative "./load_arguments"

class ExecuteCli
  class PositionalArgumentSpecification
    attr_reader :name, :description, :position, :type

    def initialize(name:, description:, position:, type: :string)
      @name = name
      @description = description
      @position = position
      @type = type
    end
  end

  class FlagSpecification
    attr_reader :name, :description, :short_name

    def initialize(name:, description:, short_name: nil)
      @name = name
      @description = description
      @short_name = short_name
    end

    def possible_cli_names
      [
        "--#{name}",
        short_name.nil? ? nil : "-#{short_name}"
      ].compact
    end
  end

  def initialize(dependencies:)
    @dependencies = dependencies
    @positional_arguments = []
    @flags = []
  end

  def with_positional_argument(**kwargs)
    @positional_arguments << PositionalArgumentSpecification.new(
      position: @positional_arguments.size, **kwargs
    )
    self
  end

  def with_flag(**kwargs)
    @positional_arguments << FlagSpecification.new(**kwargs)
    self
  end

  def call
    args_hash = LoadArguments.new.call(
      positional_argument_specifications: @positional_arguments,
      flag_specifications: @flags
    )

    yield @dependencies, args_hash
  end
end
