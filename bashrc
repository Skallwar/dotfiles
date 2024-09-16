# Unlimited history
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTFILE=~/.bash_eternal_history

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# function prompt_cmd
# {
#     res=$?
#     if [[ "$res" == "0" ]]; then
#         export PS1="[\[$(tput sgr0)\]\[\033[38;5;3m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]]\[$(tput sgr0)\]\[\033[38;5;1m\]\\$\[$(tput sgr0)\] "
#     else
#         export PS1="[\[$(tput sgr0)\]\[\033[38;5;3m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]][\[$(tput sgr0)\]\[\033[38;5;1m\]\$?\[$(tput sgr0)\]]\[$(tput sgr0)\]\[\033[38;5;1m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
#     fi
# }
# PROMPT_COMMAND=prompt_cmd

eval "$(starship init bash)"
eval "$(direnv hook bash)"

# export PS1="[\[$(tput sgr0)\]\[\033[38;5;3m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]]\[$(tput sgr0)\]\$(__RET=\$?; if [ \$__RET != 0 ]; then echo [\e[31m\$__RET\e[0m]; fi)\[\033[38;5;1m\]\\$\[$(tput sgr0)\] "
# PS1_BASE="[\[$(tput sgr0)\]\[\033[38;5;11m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]]\[$(tput sgr0)\]"
# PS1_EXIT_CODE="\$(__RET=\$?; if [ \$__RET != 0 ]; then echo [\e[31m\$__RET\e[0m] && true; fi)"
# PS1_DOLLAR="\[\033[38;5;1m\]\\$\[$(tput sgr0)\]"
# export PS1="$PS1_BASE$PS1_EXIT_CODE$PS1_DOLLAR "

# Man colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Exports
export PATH="${PATH}:$HOME/.cargo/bin:${HOME}/.local/bin:${HOME}/dotfiles/tools:${HOME}/BayLibre/adi/adi-tools"
export EDITOR="nvim"

# GPG
export GPG_TTY=$(tty)

# Alias
alias vim="nvim"
alias svim="sudo -E nvim"
alias shx="sudo -E hx"
alias zshrc="vim $(readlink ~/.zshrc)"
alias bashrc="vim $(readlink ~/.bashrc)"
alias vimrc="vim $(readlink ~/.vimrc)"
eval "$(thefuck --alias)"
alias ls="ls -h --color=auto"
alias tree="tree -C"
alias lock="~/.dotfiles/lock.sh"
alias listpkg='yay -Qet'
alias host_suspend='distrobox-host-exec systemctl suspend'
alias suspend='systemctl suspend || host_suspend'
alias hotspot='nmcli connection up Arch-USB || nmcli connection up Arch-PCI'
alias watch='watch -c'
alias less='less -R'
alias sl='sl -wed'
# alias untar="tar -xvf "
# alias untargz="tar -zxvf "
