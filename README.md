# dotfiles
Personal dotfiles and development tools managed with [mise](https://mise.jdx.dev/).

## Setup

Clone this repository and run the bootstrap script for your platform. The script installs mise if needed and applies the configuration.

If mise is not installed, bootstrap requires curl on Linux or WinGet on Windows.

### Linux

```sh
git clone https://github.com/TiggeZaki/dotfiles.git
cd ./dotfiles
./bootstrap.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/TiggeZaki/dotfiles.git
Set-Location .\dotfiles
.\bootstrap.ps1
```

Both scripts trust the local checkout and run `mise bootstrap`. Review the configuration before running them. Additional arguments, such as `--dry-run` and `--skip tools`, are forwarded to mise.

## Configuration

Shared tool versions and settings are defined in `.config/mise/config.toml`.

Keep machine-specific settings separate from the shared configuration in the following local files:

- ~/.config/mise/config.local.toml — machine-specific mise tool versions and settings
- ~/.config/git/config.local — machine-specific Git settings
- ~/.config/zsh/zshrc.local — machine-specific Zsh settings

## Updates

Pull the latest changes, preview, and apply the configuration:

```sh
git pull --ff-only
mise bootstrap --dry-run
mise bootstrap
```
