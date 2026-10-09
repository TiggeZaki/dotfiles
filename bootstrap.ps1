# Forward mise bootstrap flags, e.g. .\bootstrap.ps1 --force-dotfiles.
$ErrorActionPreference = 'Stop'
$bootstrapArgs = @($args)

# Verify the mise configuration.
$miseConfig = Join-Path $PSScriptRoot 'mise.toml'
if (-not (Test-Path -LiteralPath $miseConfig -PathType Leaf)) {
    throw "mise configuration not found: $miseConfig"
}

if (-not (Get-Command mise -ErrorAction SilentlyContinue)) {
    if (-not (Get-Command winget -CommandType Application -ErrorAction SilentlyContinue)) {
        throw 'WinGet is required to install mise. Install App Installer and run bootstrap again.'
    }

    winget install --id jdx.mise --exact --silent --disable-interactivity `
        --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        throw "WinGet failed to install mise (exit code $LASTEXITCODE)."
    }
}

mise --cd $PSScriptRoot trust $miseConfig
if ($LASTEXITCODE -ne 0) {
    throw "Failed to trust the dotfiles configuration (exit code $LASTEXITCODE)."
}
mise --cd $PSScriptRoot bootstrap --yes @bootstrapArgs
if ($LASTEXITCODE -ne 0) {
    throw "Dotfiles bootstrap failed (exit code $LASTEXITCODE)."
}
