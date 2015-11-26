# Git branch completion
if [ -f /usr/share/git_completion/add_git_branch_autocomplete ]; then
  custom_git_commands=( gc gl gcm gcam gri grh gint gsh gdt gitg )
  for com in "${custom_git_commands[@]}"; do
    . /usr/share/git_completion/add_git_branch_autocomplete $com
  done
fi

# Git switch completion
if [ -f /usr/share/git_completion/complete_custom_gswitch ]; then
  git_switch_commands=( gsw gswitch )
  for com in "${git_switch_commands[@]}"; do
    . /usr/share/git_completion/complete_custom_gswitch $com
  done
fi
