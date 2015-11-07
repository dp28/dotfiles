require 'spec_helper'

describe 'dotfiles_utils.sh' do
  describe 'contains_element' do
    let(:array)            { ['a', 'group', 'of', 'string'] }
    let(:contains_element) { "contains_element #{@element} ${array[@]}" }
    let(:success_value)    { 'success' }

    let(:command) do
      Dotfiles.run "if #{contains_element} ; then echo #{success_value} ; fi",
        pre_include: [ "array=(#{array.join ' '})" ]
    end

    it 'should return a truthy value for each element in the array' do
      array.each do |element|
        @element = element
        expect(command).to include success_value
      end
    end

    it 'should return a falsy value for elements not in the array' do
      ['an', 'expected', 'failure'].each do |element|
        @element = element
        expect(command).not_to include success_value
      end
    end

  end
end