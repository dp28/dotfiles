class Bash
  class << self
    def run(command)
      `sh -c '#{command}'`
    end

    def source(file)
      run ". #{file}"
    end
  end
end