class DependencyContainer
  class DependencyNotRegistered < StandardError ; end

  def self.default
    new.tap do |dependencies|
      dependencies.register(:application_name) { "ticket" }
      dependencies.register_singleton(:config) { Config }
      dependencies.register_singleton(:logger) { Logger }
      dependencies.register_singleton(:jira) { Jira }
      dependencies.register_singleton(:ticket_branch) { TicketBranch }

      dependencies.register_singleton(:fetch_input, file_path: './input/fetch_input') do
        FetchInput
      end
    end
  end

  def initialize
    @dependencies = {}
    @constructors = {}
  end

  def override(name, value)
    @dependencies[name] = value
  end

  def resolvable?(name)
    @dependencies[name] || @constructors[name]
  end

  def fetch(name)
    raise DependencyNotRegistered.new(name) unless resolvable?(name)

    @dependencies[name] ||= @constructors[name].call(self)
  end

  def register(name)
    @constructors[name] = ->(dependencies) { yield dependencies }
  end

  def register_singleton(name, file_path: nil)
    register(name) do |dependencies|
      require_relative "./#{file_path || name}"

      yield.new(dependencies: dependencies)
    end
  end
end
