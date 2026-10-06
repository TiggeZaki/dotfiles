# Load Git completion after the prompt becomes idle to keep startup responsive.
if ($null -ne (Get-Module -ListAvailable -Name git-completion)) {
    $null = Register-EngineEvent `
        -SourceIdentifier ([Management.Automation.PSEngineEvent]::OnIdle) `
        -MaxTriggerCount 1 `
        -Action {
            Import-Module git-completion
        }
}

Set-PSReadLineOption -BellStyle None

# eza shortcuts
if (Get-Command eza) {
    function l   { eza @args }
    function la  { eza -a @args }
    function ll  { eza -l --git --icons @args }
    function lla  { eza -al --git --icons @args }
    function lt  { eza -T --icons @args }
    function lta { eza -aT --icons @args }
}

# Interactive completion
if (
    $Host.Name -eq 'ConsoleHost' -and
    (Get-Command Set-PSReadLineKeyHandler)
) {
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

    if ($null -ne (Get-Module -ListAvailable -Name PSFzf)) {
        Import-Module PSFzf
    }
}

if (Get-Command starship) {
    Invoke-Expression (&starship init powershell)
}
