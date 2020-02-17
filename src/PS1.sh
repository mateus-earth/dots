##~---------------------------------------------------------------------------##
##                        _      _                 _   _                      ##
##                    ___| |_ __| |_ __ ___   __ _| |_| |_                    ##
##                   / __| __/ _` | '_ ` _ \ / _` | __| __|                   ##
##                   \__ \ || (_| | | | | | | (_| | |_| |_                    ##
##                   |___/\__\__,_|_| |_| |_|\__,_|\__|\__|                   ##
##                                                                            ##
##  File      : misc.sh                                                       ##
##  Project   : dots                                                          ##
##  Date      : Jan 06, 2019                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : stdmatt <stdmatt@pixelwizards.io>                             ##
##  Copyright : stdmatt - 2019, 2020                                          ##
##                                                                            ##
##  Description :                                                             ##
##    My custom PS1.                                                          ##
##---------------------------------------------------------------------------~##

##----------------------------------------------------------------------------##
## Imports                                                                    ##
##----------------------------------------------------------------------------##
source /usr/local/src/stdmatt/shellscript_utils/main.sh


##----------------------------------------------------------------------------##
## Constants                                                                  ##
##----------------------------------------------------------------------------##
_DOTS_COLOR_PWD=64
_DOTS_COLOR_GIT=241
_DOTS_COLOR_PROMPT=247

##
## Prompt
_DOTS_PROMPT_LAMBDA="λ";
_DOTS_PROMPT_SMILE=":)";


##----------------------------------------------------------------------------##
## Functions                                                                  ##
##----------------------------------------------------------------------------##
_dots_color()
{
    local COLOR=$1;
    local MSG=$2;

    echo -e "\033[38;5;${COLOR}m"$MSG"\033[0m";
}

##------------------------------------------------------------------------------
_dots_parse_git_branch()
{
    local BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    local STR="";
    if [ ! "${BRANCH}" == "" ]; then
        local TAG=$(git describe --tags $(git rev-list --tags --max-count=1) 2> /dev/null);
        if [ -n "$TAG" ]; then
            STR="(${BRANCH}:${TAG})";
        else
            STR="(${BRANCH})";
        fi;
    else
       STR="";
    fi
    echo $(_dots_color 245 $STR);
}

_dots_get_pwd()
{
    echo $(_dots_color 202 $(basename $PWD));
}

##------------------------------------------------------------------------------
_dots_random_prompt()
{
    ## @todo(stdmatt): Put the prompts on an array and
    ## make it choose them automatically...
    local COUNT=2;
    local INDEX=$(( RANDOM % COUNT ));
    local PROMPT="";
    if [ $INDEX == 0 ]; then
        PROMPT="$_DOTS_PROMPT_LAMBDA";
    else
        PROMPT="$_DOTS_PROMPT_SMILE";
    fi;

    echo "$(_dots_color 252 $PROMPT)";
}

##------------------------------------------------------------------------------
_dots_get_os_name()
{
    echo "$(_dots_color 75 $(pw_os_get_simple_name))";
}

##----------------------------------------------------------------------------##
## Exports                                                                    ##
##----------------------------------------------------------------------------##
_DOTS_STR_PROMPT="$(_dots_random_prompt)";
_DOTS_OS_NAME="$(_dots_get_os_name)"

##------------------------------------------------------------------------------
export PS1="\n${_DOTS_OS_NAME}:`_dots_get_pwd`:`_dots_parse_git_branch`\n${_DOTS_STR_PROMPT} "