# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/esteban/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

## Zgen
# load zgen
source "${HOME}/.zgen/zgen.zsh"
# if the init script doesn't exist
    if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh

  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo

  zgen load caiogondim/bullet-train-oh-my-zsh-theme bullet-train

  # generate the init script from plugins above
  zgen save
fi

# Theme
ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_ORDER=(
    time
    context
    dir
    git
)

# Autostart
neofetch

# Alias
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias untar='tar -zxvf '
alias yay -R= "yay -Rcsn"
alias i3lock="i3lock -i $(find ~/dotfiles/IMG/DESKTOP/ -name "*png" | shuf -n1)"

# Man colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
