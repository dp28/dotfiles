
def run_spec(spec_file)
  system "rspec #{spec_file}"
end

puts 'Waiting for changes ...'

watch('src/(.*)\.') do |match_data|
  run_spec "spec/#{match_data[1]}_spec.rb"
end

watch('spec/.*_spec\.rb') do |match_data|
  run_spec match_data[0]
end