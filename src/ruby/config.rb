require "yaml"

class Config
  class MissingConfigurationError < StandardError
    def initialize(keys)
      super("No config value found for #{keys.join('.')}")
    end
  end

  def initialize(dependencies:)
    @dependencies = dependencies
  end

  def get(*keys, default: nil)
    result = config_hash.dig(*keys.map(&:to_s))
    return result unless result.nil?

    if default.nil?
      raise MissingConfigurationError.new(keys)
    else
      default
    end
  end

  private

  CONFIG_FILE_PATHS = %w(~/. ./. config/)
  private_constant :CONFIG_FILE_PATHS

  def config_hash
    @config_hash ||= load_config_hash
  end

  def load_config_hash
    application_name = @dependencies.fetch(:application_name)

    CONFIG_FILE_PATHS
      .map { |directory| "#{directory}#{application_name}.yml" }
      .select { |path| File.exists?(path) }
      .reduce({}) { |hash, path| hash.merge(YAML.load_file(path)) }
  end
end
