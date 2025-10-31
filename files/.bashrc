
[[ $- != *i* ]] && return

export PS1='\[\e[31m\][\[\e[96m\]\u\[\e[95m\]@\[\e[94m\]\H\[\e[31m\]]\[\e[0m\] \W \$ '

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias less='less -R'
