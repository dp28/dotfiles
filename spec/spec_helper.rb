require 'fileutils'

require './spec/support/dotfiles'
require './spec/support/bash'
require './spec/support/factories/file_factory'
require './spec/support/factories/bash_file_factory'

SPEC_RUN_DIR     = 'spec_env'
DIRS_NOT_TO_COPY = ['.git', 'spec', SPEC_RUN_DIR]

def sync(source, destination, options = '')
  exclude = DIRS_NOT_TO_COPY.map { |dir| "--exclude #{dir}" }.join ' '
  `rsync -a #{source} #{destination} #{exclude} #{options}`
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before(:suite) do
    sync '.', SPEC_RUN_DIR
    Dir.chdir SPEC_RUN_DIR
    puts "Running tests in #{`pwd`}"
  end

  config.after(:each) { sync '..', '.', '--delete' }

  config.after(:suite) do
    Dir.chdir '..'
    FileUtils.rm_rf SPEC_RUN_DIR
  end
end
