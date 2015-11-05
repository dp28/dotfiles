require 'spec_helper'

describe 'include.sh' do
  context 'with an .sh file in the current directory' do
    let(:string)  { 'Hello, world!' }

    before { BashFileFactory.create_file 'test.sh', "echo \"#{string}\"" }

    it 'should be sourced' do
      expect(Dotfiles.include).to eq string + "\n"
    end
  end
end