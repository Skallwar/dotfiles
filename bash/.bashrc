# Unlimited history
HISTSIZE=
HISTFILESIZE=

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

function prompt_cmd
{
    res=$?
    if [[ "$res" == "0" ]]; then
        export PS1="[\[$(tput sgr0)\]\[\033[38;5;3m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]]\[$(tput sgr0)\]\[\033[38;5;1m\]\\$\[$(tput sgr0)\] "
    else
        export PS1="[\[$(tput sgr0)\]\[\033[38;5;3m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]]\[$(tput sgr0)\]\\[[\033[38;5;1m\]$res\[$(tput sgr0)\]]\[\033[38;5;1m\]$\[$(tput sgr0)\] "
    fi
}
PROMPT_COMMAND=prompt_cmd

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
#bindkey -e
#bindkey "\e[3~" delete-char

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
