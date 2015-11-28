setopt correctall
setopt autocd

fpath=($DOTFILES_HOME/src/zsh/completion $fpath)

autoload -U compinit
compinit