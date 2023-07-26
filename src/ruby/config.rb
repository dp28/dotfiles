require "yaml"

class Config
  class MissingConfigurationError < StandardError
    def initialize(keys)
      super("No config value found for #{keys.join('.')}")
    end
  end

  CONFIG_FILE_PATHS = %w(~/. ./. config/)

  def self.load(file_name)
    hash = CONFIG_FILE_PATHS
      .map { |directory| "#{directory}#{file_name}.yml" }
      .select { |path| File.exists?(path) }
      .reduce({}) { |hash, path| hash.merge(YAML.load_file(path)) }

    new(config_hash: hash)
  end

  def initialize(config_hash:)
    @config_hash = config_hash
  end

  def get(*keys, default: nil)
    result = @config_hash.dig(*keys.map(&:to_s))
    return result unless result.nil?

    if default.nil?
      raise MissingConfigurationError.new(keys)
    else
      default
    end
  end
end
