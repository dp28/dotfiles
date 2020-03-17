# Dotfiles

A rewrite of my old dotfiles so that some aspects can be shared and other
(domain-specific) areas can be maintained separately. The aim is to have a set
of dotfiles that are quick and easy to add to, while also being self-documented
(so that I can remember how to use commands I don't use very frequently).

## Installation

```bash
cd ~
git clone https://github.com/dp28/dotfiles.git
cd dotfiles

# either
make install 
# or
make add_symlinks
```

Add the following to `~/.bashrc`:

```bash
export DOTFILES_HOME=~/dotfiles
. ~/dotfiles/include.sh
```

### On Mac OS X
Also:

1. Install git completion:

```bash
brew install git bash-completion
```

2. Add bash completion to `~/.bashrc`:

```bash
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
```

3. Use `bash`, not `zsh`, and source `~/.bashrc` from `~/.bash_profile`.

## Commands
### `dotfiles` (or `dfs`)
Re-sources the dotfiles directory

## License

MIT
