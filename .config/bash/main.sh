# If not running interactively, don't do anything
[[ $- != *i* ]] && return

echo "math.earch config";

##-----------------------------------------------------------------------------
. "${HOME}/.config/bash/bashy.sh"         ## Base Library
##-----------------------------------------------------------------------------
. "${HOME}/.config/bash/environment.sh"   ## Env setup.
. "${HOME}/.config/bash/bash_options.sh"  ## Config bash itself.
. "${HOME}/.config/bash/shell.sh"         ## Functions and utilities.
. "${HOME}/.config/bash/alias.sh"         ## Makes life easier.
. "${HOME}/.config/bash/ssh.sh"           ## SSH utilities.
##-----------------------------------------------------------------------------

test -f "${HOME}/.private/main.sh" && source "${HOME}/.private/main.sh";

return;


