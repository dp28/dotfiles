class Bash
  class << self
    def run(command)
      `bash -c '#{command}'`
    end
  end
end