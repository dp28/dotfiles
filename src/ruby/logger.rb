class Logger
  LEVELS = %i(debug info warning error)

  def initialize(dependencies:, level: :info, prefix: nil)
    @level = level
    @prefix = prefix
  end

  LEVELS.each do |level_name|
    define_method("#{level_name}") do |message|
      if LEVELS.find_index(level_name) >= current_index
        string = prefix.nil? ? message : "#{prefix}#{message}"
        puts string
      end
      nil
    end

    define_method("#{level_name}!") do
      @level = level_name
    end

    define_method("#{level_name}?") do
      LEVELS.find_index(level_name) >= current_index
    end
  end

  private

  def current_index
    LEVELS.find_index(@level)
  end
end
