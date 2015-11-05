require './spec/support/bash'

class Dotfiles
  class << self
    def include
      Bash.source './include.sh'
    end
  end
end