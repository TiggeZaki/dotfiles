# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Setup

After installing chezmoi, initialize it with this repository:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
"$HOME/.local/bin/chezmoi" init --apply <repository-url>
```

To review the changes before applying them, run:

```sh
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```

On Debian/Ubuntu-based Linux systems, `chezmoi apply` installs any missing packages and downloads Zsh plugins into `~/.zsh`. The package installation script is rerun only when its contents change.