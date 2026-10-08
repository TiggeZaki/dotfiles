# Git completion
if (Get-Module -ListAvailable -Name git-completion) {
    Register-ArgumentCompleter -CommandName git -Native -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        Complete-Git -CommandAst $commandAst -CursorPosition $cursorPosition
    }
}

# Interactive shell settings
if ($Host.Name -eq 'ConsoleHost') {
    Set-PSReadLineOption -BellStyle None
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

    if (Import-Module PSFzf -PassThru -ErrorAction Ignore) {
        Set-PsFzfOption `
            -PSReadlineChordProvider 'Ctrl+t' `
            -PSReadlineChordReverseHistory 'Ctrl+r'
    }
}

# eza shortcuts
if (Get-Command eza -ErrorAction Ignore) {
    function l   { eza @args }
    function la  { eza -a @args }
    function ll  { eza -l --git --icons @args }
    function lla  { eza -al --git --icons @args }
    function lt  { eza -T --icons @args }
    function lta { eza -aT --icons @args }
}

# Starship prompt
if (Get-Command starship -ErrorAction Ignore) {
    Invoke-Expression (&starship init powershell)
}
