require 'spec_helper'

describe 'include.sh' do
  context 'with an .sh file in the current directory' do
    let(:root_dir_echo) { 'Hello, world!' }

    before { echo_script 'an_include_test.sh', root_dir_echo }

    it 'should be sourced' do
      expect(Dotfiles.include).to eq root_dir_echo + "\n"
    end

    context 'and another .sh file in a subdirectory' do
      let(:subdir_echo) { 'What\'s the weather like up there?' }

      before { echo_script 'include_test/a_subdir_test.sh', subdir_echo }

      it 'should source both files' do
        expect(Dotfiles.include).to eq root_dir_echo + "\n" + subdir_echo + "\n"
      end

      context 'and yet another .sh file two directories down' do
        let(:deep_echo) { 'It\'s cold and dark down here' }

        before { echo_script 'include_test_two/levels/down.sh', deep_echo }

        it 'should source both files' do
          result = [root_dir_echo, subdir_echo, deep_echo].join("\n") + "\n"
          expect(Dotfiles.include).to eq result
        end
      end
    end

    context 'and an .sh file in the src/preload directory' do
      let(:preload_echo) { 'Prelocked and preloaded' }

      before { echo_script 'src/preload/preload_test.sh', preload_echo }

      it 'should source the file in the preload directory, then any others' do
        result = preload_echo + "\n" + root_dir_echo + "\n"
        expect(Dotfiles.include).to eq result
      end
    end
  end

  def echo_script(name, to_echo)
    BashFileFactory.create_file name, "echo \"#{to_echo}\""
  end
end