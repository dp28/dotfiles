require 'spec_helper'


describe 'modes.sh' do
  MODES = ['test', 'normal']
  before(:all) { Dotfiles.include }

  describe 'DOTFILES_MODES' do
    subject(:modes) { Dotfiles.run 'echo ${DOTFILES_MODES[@]}' }

    MODES.each { |mode| it { should include mode } }
  end

  describe 'dotfiles_mode' do
    context 'with no arguments' do
      subject(:mode) { Dotfiles.run 'echo `dotfiles_mode`', pre_include: setup }

      context 'when no mode has been set' do
        let(:setup) { [] }
        it { should include 'normal' }
      end

      MODES.each do |mode|
        context "with the mode set to '#{mode}'" do
          let(:setup) { [ "DOTFILES_MODE='#{mode}'" ] }
          it { should include mode }
        end
      end
    end

    context 'with one argument' do
      subject(:mode) { Dotfiles.run "echo `dotfiles_mode #{argument}`" }

      context 'when the argument is "test"' do
        let(:argument) { 'test' }
        it 'should set the mode to "test" and echo it' do
          expect(mode).to include 'test'
        end

        it 'should not be invalid' do
          expect(mode).not_to include 'Invalid'
        end
      end

      context 'when the argument is "normal"' do
        let(:argument) { 'normal' }
        it 'should set the mode to "normal" and echo it' do
          expect(mode).to include 'normal'
        end

        it 'should not be invalid' do
          expect(mode).not_to include 'Invalid'
        end
      end

      context 'when the argument is "anormal"' do
        let(:argument) { 'anormal' }

        it 'should be invalid' do
          expect(mode).to include 'Invalid'
        end
      end
    end

  end
end