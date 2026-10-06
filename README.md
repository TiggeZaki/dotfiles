# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Setup

On Linux and other Unix-like systems, install chezmoi and initialize it with this repository:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
"$HOME/.local/bin/chezmoi" init --apply <repository-url>
```

On Windows, use winget instead:

```powershell
winget install --id twpayne.chezmoi --exact --accept-package-agreements --accept-source-agreements
chezmoi init --apply <repository-url>
```

To review subsequent changes before applying them, run:

```sh
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```
