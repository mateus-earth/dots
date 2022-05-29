
##
## Inspired by:
##    https://github.com/stdmatt/bash-sensible/blob/master/sensible.bash

##------------------------------------------------------------------------------
## SHOPT
shopt -s cdspell                ## autocorrects cd misspellings
shopt -s cmdhist                ## save multi-line commands in history as single line
shopt -s expand_aliases         ## expand aliases
shopt -s histappend             ## Append to the history file
shopt -s checkwinsize           ## Check the window size after each command ($LINES, $COLUMNS)
shopt -s nocaseglob;            ## Case-insensitive globbing (used in pathname expansion)
shopt -s globstar 2> /dev/null  ## Turn on recursive globbing (enables ** to recurse all directories)

bind "set completion-ignore-case on" ## ignore upper and lowercase when TAB completion

## Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

## SMARTER TAB-COMPLETION (Readline bindings) ##
bind "set completion-ignore-case on"     ## Perform file completion in a case insensitive fashion
bind "set completion-map-case on"        ## Treat hyphens and underscores as equivalent
bind "set show-all-if-ambiguous on"      ## Display matches for ambiguous patterns at first tab press
bind "set mark-symlinked-directories on" ## Immediately add a trailing slash when autocompleting symlinks to directories
