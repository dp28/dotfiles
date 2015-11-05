require 'fileutils'

class FileFactory
  class << self
    def create_file(path, content)
      ensure_dir_exists File.dirname path
      File.open(path, 'w') { |file| file.write content }
    end

    private

    def ensure_dir_exists(path)
      FileUtils.mkdir_p(path) unless File.directory? path
    end
  end
end