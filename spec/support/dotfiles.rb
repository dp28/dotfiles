require_relative './bash'

class Dotfiles
  class << self
    def include
      run
    end

    def run(*commands, pre_include: [])
      command_string = (pre_include + [include_command] + commands).join ' && '
      Bash.run command_string
    end

    private

    def include_command
      '. ./include.sh'
    end
  end
end