require 'fileutils'

class FileFactory
  class << self
    def create_file(path, content)
      ensure_dir_exists File.dirname path
      File.open(path, 'w') { |file| file.write content }
      @@paths_created << path
    end

    def cleanup
      @@paths_created.each { |path| FileUtils.rm_rf(path) if File.exists? path }
      @@paths_created = []
    end

    private

    def ensure_dir_exists(path)
      @@paths_created ||= []
      unless File.directory?(path)
        @@paths_created << FileUtils.mkdir_p(path).first
      end
    end
  end
end