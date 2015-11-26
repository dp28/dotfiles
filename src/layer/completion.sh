# Enables tab completion of layer-terminal commands and options
_layer_completions()
{
  local cur_word args type_list

  cur_word="${COMP_WORDS[COMP_CWORD]}"
  args=$(printf "%s " "${COMP_WORDS[@]}")
  type_list=`layer-completion $args`

  COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )

  # if no match was found, fall back to filename completion
  if [ ${#COMPREPLY[@]} -eq 0 ]; then
    COMPREPLY=( $(compgen -f -- "${cur_word}" ) )
  fi

  return 0
}
