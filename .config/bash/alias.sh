test $ALIAS_SH_LOADED && return;
ALIAS_SH_LOADED=1;

. "${HOME}/.config/bash/shell.sh"; ## Alias are dependend of the shell functions.


##
## cd
##

##------------------------------------------------------------------------------
alias ..="cd ..";
alias ...="cd ..";

##
## grep
##

##------------------------------------------------------------------------------
alias grep="grep --color=auto";
alias egrep="egrep --color=auto";
alias fgrep="fgrep --color=auto";

##
## ls
##

##------------------------------------------------------------------------------
alias ls="ls --color='auto'";

##
## ps
##

##------------------------------------------------------------------------------
alias ps-tree="ps auxf";


##-----------------------------------------------------------------------------##
## One Letter Aliases                                                          ##  
##-----------------------------------------------------------------------------##
alias d="dots ";
alias e="_edit ";
alias f="_files ";
alias g="_git ";
alias v="_vm ";
