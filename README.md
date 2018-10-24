# Dotfiles

A rewrite of my old dotfiles so that some aspects can be shared and other
(domain-specific) areas can be maintained separately. The aim is to have a set
of dotfiles that are quick and easy to add to, while also being self-documented
(so that I can remember how to use commands I don't use very frequently).

## Commands
### `dotfiles` (or `dfs`)
Re-sources the dotfiles directory

### `dotfiles_mode [mode]`
Without any argument, shows he current mode. With an argument, sets the argument
as the mode. 'test' and 'normal' are the only valid modes. In 'test' mode, all
dotfiles are re-sourced before each command is run.

### `run [command]`
Echoes the command, then, if in 'normal' dotfiles_mode, executes the command.

## License

MIT
