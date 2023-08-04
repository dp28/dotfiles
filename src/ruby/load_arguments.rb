class LoadArguments
  class InvalidArgumentsError < StandardError ; end

  def initialize
    @parsed_args = {}
  end

  def call(positional_argument_specifications: [], flag_specifications: [], args_list: ARGV)
    args_without_flags = extract_flags(args_list, flag_specifications)
    positional_args = extract_named_args(args_without_flags)
    parse_positional_args(positional_args, positional_argument_specifications)
    @parsed_args
  end

  private

  def extract_flags(args_list, flag_specifications)
    args_list.select do |arg|
      !flag_specifications.any? { |flag_spec| parse_flag?(arg, flag_spec) }
    end
  end

  def parse_flag?(arg_string, flag_spec)
    flag_spec.possible_cli_names.include?(arg).tap do
      @parsed_args[flag_spec.name] = true
    end
  end

  def extract_named_args(args_without_flags)
    arg_name_indexes = args_without_flags.map.with_index do |arg, index|
      arg.start_with?("-") ? index : nil
    end.compact

    arg_name_indexes.each do |name_index|
      name = args_without_flags[name_index]
      value = args_without_flags[name_index + 1]
      @parsed_args[parse_name(name)] = value
    end

    args_without_flags.select.with_index do |_value, index|
      !arg_name_indexes.any? do |name_index|
        index == name_index || index == name_index + 1
      end
    end
  end

  def parse_name(arg_name)
    arg_name.gsub(/^-+/, '').gsub('-', '_').to_sym
  end

  def parse_positional_args(positional_args, positional_argument_specifications)
    ensure_correct_number_of_positional_arguments(
      expected: positional_argument_specifications.size,
      actual: positional_args.size
    )

    positional_args.each_with_index do |arg, index|
      spec = positional_argument_specifications.find { |s| s.position == index }
      @parsed_args[spec.name] = arg
    end
  end

  def ensure_correct_number_of_positional_arguments(expected:, actual:)
    if expected != actual
      raise InvalidArgumentsError.new(
        "Incorrect number of positional arguments: #{actual} given, #{expected} expected"
      )
    end
  end
end
