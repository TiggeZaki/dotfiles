#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Verify the mise configuration.
mise_config="$script_dir/mise.toml"
if [ ! -f "$mise_config" ]; then
  printf 'mise configuration not found: %s\n' "$mise_config" >&2
  exit 1
fi

if command -v mise >/dev/null 2>&1; then
  mise_bin="$(command -v mise)"
elif [ -x "$HOME/.local/bin/mise" ]; then
  mise_bin="$HOME/.local/bin/mise"
else
  if ! command -v curl >/dev/null 2>&1; then
    printf 'curl is required to install mise.\n' >&2
    exit 1
  fi

  mise_bin="$HOME/.local/bin/mise"
  mise_installer="$(curl -fsSL https://mise.run)"
  printf '%s\n' "$mise_installer" | MISE_INSTALL_PATH="$mise_bin" sh
fi

"$mise_bin" --cd "$script_dir" trust "$mise_config"
exec "$mise_bin" --cd "$script_dir" bootstrap --yes "$@"
