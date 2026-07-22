bindkey -e
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line


bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word




autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
autoload -Uz history-substring-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N history-substring-search-up
zle -N history-substring-search-down




bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history


bindkey '^[[1;5A' up-line-or-beginning-search
bindkey '^[[1;5B' down-line-or-beginning-search


bindkey '^[[1;3A' history-substring-search-up
bindkey '^[[1;3B' history-substring-search-down

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
