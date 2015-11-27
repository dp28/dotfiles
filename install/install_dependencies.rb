#! /usr/bin/env ruby

require 'yaml'

dependencies = YAML.load_file ARGV.first
dependencies.each do |install_command, values|
  values.each do |value|
    command = "#{install_command} #{value}"
    puts command
    `#{command}`
  end
end