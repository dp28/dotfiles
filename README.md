# Dotfiles

A rewrite of my old dotfiles so that some aspects can be shared and other 
(domain-specific) areas can be maintained separately. The aim is to have a set 
of dotfiles that are quick and easy to add to, while also being self-documented
(so that I can remember how to use commands I don't use very frequently).

## Commands
### `dotfiles` (or `dfs`)
Re-sources the dotfiles directory

### `dotfiles_help [command]`
Prints the help for a given command. 

### `dotfiles_mode [mode]`
Without any argument, shows he current mode. With an argument, sets the argument
as the mode. 'test' and 'normal' are the only valid modes. In 'test' mode, all
dotfiles are re-sourced before each command is run.

### `run [command]`
Echoes the command, then, if in 'normal' dotfiles_mode, executes the command.

### Other commands
Other commands are described by the specs, just run: 

```rspec --format doc``` 

in the dotfiles direcory to get a full description of all commands.

## Tests

Specs are written in RSpec. Specs are run in a directory newly created for each 
run of the suite and deleted afterwards. To run them, just run `rspec` in your
dotfiles directory.

## Development
Recommended development is to use test-driven development and/or set the 
dotfiles_mode to 'test'. Test mode speeds development as all files are 
re-sourced before each command. 

Furthermore, if the functions being written prefix commands with `run` then 
dangerous/long-running commands can be included safely and quickly as `run` does 
not actually execute commands in test mode.

## License

MIT