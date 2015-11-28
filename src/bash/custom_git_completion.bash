custom_git_commands=( gc gl gcm gcam gri grh gint gsh gdt gitg )

for com in "${custom_git_commands[@]}"; do
  . $DOTFILES_HOME/src/bash/add_git_branch_completion_to_command.bash $com
done

# Git switch completion
if [ -f /usr/share/git_completion/complete_custom_gswitch ]; then
  git_switch_commands=( gsw gswitch )
  for com in "${git_switch_commands[@]}"; do
    . /usr/share/git_completion/complete_custom_gswitch $com
  done
fi

unset com
unset custom_git_commands
unset git_switch_commands