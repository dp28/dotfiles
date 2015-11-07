require 'fileutils'

class SpecDirectory

  SPEC_RUN_DIR     = 'spec_env'
  DIRS_NOT_TO_COPY = ['.git', 'spec', SPEC_RUN_DIR]

  class << self

    def setup
      sync '.', SPEC_RUN_DIR
      Dir.chdir SPEC_RUN_DIR
    end

    def teardown
      Dir.chdir '..'
      FileUtils.rm_rf SPEC_RUN_DIR
    end

    def reset
      sync '..', '.', '--delete'
    end

    private

    def sync(source, destination, options = '')
      exclude = DIRS_NOT_TO_COPY.map { |dir| "--exclude #{dir}" }.join ' '
      `rsync -a #{source} #{destination} #{exclude} #{options}`
    end
  end
end