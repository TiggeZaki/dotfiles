# Git completion
if (Get-Module -ListAvailable -Name git-completion) {
    Register-ArgumentCompleter -CommandName git -Native -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        Complete-Git -CommandAst $commandAst -CursorPosition $cursorPosition
    }
}

# Aliases
function l   { eza @args }
function la  { eza -a @args }
function ll  { eza -l --git --icons @args }
function lla  { eza -al --git --icons @args }
function lt  { eza -T --icons @args }
function lta { eza -aT --icons @args }

if (Get-Command mise -ErrorAction Ignore) {
    (&mise activate pwsh) | Out-String | Invoke-Expression
}

# Interactive shell settings
if ($Host.Name -eq 'ConsoleHost') {
    Set-PSReadLineOption -BellStyle None -EditMode Emacs
    Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+Backspace' -Function BackwardKillWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+Delete' -Function KillWord
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

    if (Import-Module PSFzf -PassThru -ErrorAction Ignore) {
        Set-PsFzfOption `
            -PSReadlineChordProvider 'Ctrl+t' `
            -PSReadlineChordReverseHistory 'Ctrl+r'
    }
}

# Starship prompt
if (Get-Command starship -ErrorAction Ignore) {
    Invoke-Expression (&starship init powershell)
}
