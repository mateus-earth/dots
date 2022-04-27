##
## Imports
##

. "${HOME}/.config/powershell/path.ps1"; ## PATH must be set to PS modules
Import-Module PSFzf;


##
## PSReadline
##

##------------------------------------------------------------------------------
function _on_vi_mode_change
{
    if ($args[0] -eq 'Command') {
        Write-Host -NoNewLine "`e[1 q";
    } else {
        Write-Host -NoNewLine "`e[5 q";
    }
}

##------------------------------------------------------------------------------
Set-PSReadLineOption                                  `
    -ViModeIndicator     Script                       `
    -ViModeChangeHandler $Function:_on_vi_mode_change `
    -EditMode            Vi                           `
    -HistoryNoDuplicates                              `
    -PredictionSource    HistoryAndPlugin             `
    -PredictionViewStyle ListView                     `
    -Colors              @{
        Command            = "#DCDCAA";
        Comment            = "#608B4E";
        ContinuationPrompt = "#FF00FF";
        Default            = "#D4D4D4";
        Emphasis           = "#CE9178";
        Error              = "#F44747";
        InlinePrediction   = "#808080";
        ListPrediction     = "#808080";
        Keyword            = "#C586C0";
        Member             = "#D4D4D4";
        Number             = "#B5CEA8";
        Operator           = "#D4D4D4";
        Parameter          = "#C586C0";
        Selection          = "#FF00FF";
        String             = "#CE9178";
        Type               = "#569CD6";
        Variable           = "#9CDCFE";
    };

## @todo(stdmatt): Is this tab something that we want?
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock {
    Invoke-FzfTabCompletion;
}

##
## PsFzf
##

##------------------------------------------------------------------------------
Set-PsFzfOption                             `
    -PSReadlineChordProvider       "Ctrl+t" `
    -PSReadlineChordReverseHistory "Ctrl+r"
