path=(
	$HOME/.local/bin(N-/)
	$path
)
export PATH

export EDITOR='vim'

_setup_direnv(){
	mkdir -p $2
	export $1=$2
}
_setup_direnv "XDG_CONFIG_HOME" "$HOME/.config"
_setup_direnv "XDG_CACHE_HOME" "$HOME/.cache"
_setup_direnv "XDG_DATA_HOME" "$HOME/.local/share"
_setup_direnv "XDG_STATE_HOME" "$HOME/.local/state"
_setup_direnv "ZDOTDIR" "$XDG_CONFIG_HOME/zsh"

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
