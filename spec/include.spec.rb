require 'spec_helper'

describe 'include.sh' do
  let(:command) { 'sh -c ". ./include.sh"' }

  context 'with an .sh file in the current directory' do
    let(:print_value)  { 'Hello, world!' }
    let(:file_content) { "#! /usr/bin/env bash\n echo \"#{print_value}\"" }

    before { FileFactory.create_file 'test.sh', file_content }

    it 'should be sourced' do
      expect(`#{command}`).to eq print_value + "\n"
    end
  end
end