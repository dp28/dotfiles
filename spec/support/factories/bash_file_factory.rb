require './spec/support/factories/file_factory'

class BashFileFactory < FileFactory
  class << self
    def create_file(path, content)
      super path, "#! /usr/bin/env bash\n\n#{content}"
    end
  end
end