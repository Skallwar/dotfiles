#History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

#No beep
unsetopt beep

PROMPT="[%F{yellow}%n%f@%F{green}%m%f %F{blue}%~%f]%F{red}$%f "
RPS1=""

#Completion
zstyle :compinstall filename '/home/esteban/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
autoload -U compinit && compinit

#Colors
autoload -U colors && colors 
# Man colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

#Export
export EDITOR="vim"
export PATH="${PATH}:$HOME/.cargo/bin:${HOME}/.local/bin"

#Don't use vim keybing
bindkey -e
bindkey "\e[3~" delete-char

# Alias
alias zshrc="vim $(readlink ~/.zshrc)"
alias vimrc="vim $(readlink ~/.vimrc)"
alias ls="ls --color=auto"
alias tree="tree -C"
alias lock="~/.dotfiles/lock.sh"
alias listpkg='yay -Qet'
alias suspend='systemctl suspend'
alias hotspot='nmcli connection up Arch-USB || nmcli connection up Arch-PCI'
# alias untar="tar -xvf "
# alias untargz="tar -zxvf "
