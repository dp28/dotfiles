class FetchInput
  def initialize(dependencies:)
    @config = dependencies.fetch(:config)
  end

  def call(input_specification)
    key_parts = [input_specification.context, input_specification.name].compact
    @config.get(*key_parts)
  end
end
