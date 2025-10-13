eval "$(sheldon source)"

HISTFILE=$XDG_STATE_HOME/zsh_history
HISTSIZE=1000
SAVEHIST=1000

[ -d $XDG_CACHE_HOME/zsh ] || mkdir -p $XDG_CACHE_HOME/zsh
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt hist_reduce_blanks
setopt SHARE_HISTORY

bindkey -e
bindkey '^[[3~' delete-char
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

alias mv="mv -i"
alias cp="cp -i"
alias mkdir="mkdir -p"
alias l="eza"
alias la="eza -a"
alias ll="eza -al --git --icons"
alias lt="eza -T --icons"
alias grep="grep --color=auto"
alias sudo="sudo "
alias sv="sudoedit"

alias dotfiles='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'

# For WSL
# Thanks to https://github.com/microsoft/terminal/issues/3158
precmd() {
  printf "\e]9;9;%s\e\\" "$(wslpath -m "$PWD")"
}

open() {
  /mnt/c/Windows/System32/cmd.exe /c start $(wslpath -w $1) 2> /dev/null
}
