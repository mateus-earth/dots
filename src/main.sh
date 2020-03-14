##~---------------------------------------------------------------------------##
##                        _      _                 _   _                      ##
##                    ___| |_ __| |_ __ ___   __ _| |_| |_                    ##
##                   / __| __/ _` | '_ ` _ \ / _` | __| __|                   ##
##                   \__ \ || (_| | | | | | | (_| | |_| |_                    ##
##                   |___/\__\__,_|_| |_| |_|\__,_|\__|\__|                   ##
##                                                                            ##
##  File      : main.sh                                                       ##
##  Project   : dots                                                          ##
##  Date      : Oct 08, 2017                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : stdmatt <stdmatt@pixelwizards.io>                             ##
##  Copyright : stdmatt - 2018, 2019                                          ##
##                                                                            ##
##  Description :                                                             ##
##    This is the only file that will be sourced in .bashrc (.bash_profile)   ##
##    so everything that dots needs to source must be sourced from this file  ##
##    This will make all the stuff avaiable but without the hassle of         ##
##    need to include everything by hand.                                     ##
##    Thanks me later....                                                     ##
##---------------------------------------------------------------------------~##

##----------------------------------------------------------------------------##
## Variables                                                                  ##
##----------------------------------------------------------------------------##
PROJECT_ROOT_DIR="$HOME/.stdmatt/dots";


##----------------------------------------------------------------------------##
## Imports                                                                    ##
##----------------------------------------------------------------------------##
source "$PROJECT_ROOT_DIR/bench.sh"
source "$PROJECT_ROOT_DIR/datetime.sh"
source "$PROJECT_ROOT_DIR/dosbox.sh"
source "$PROJECT_ROOT_DIR/editor.sh"
source "$PROJECT_ROOT_DIR/emscripten.sh"
source "$PROJECT_ROOT_DIR/gitcheck.sh"
source "$PROJECT_ROOT_DIR/http-server.sh"
source "$PROJECT_ROOT_DIR/keyboard.sh"
source "$PROJECT_ROOT_DIR/misc.sh"
source "$PROJECT_ROOT_DIR/PS1.sh"
source "$PROJECT_ROOT_DIR/shell.sh"
source "$PROJECT_ROOT_DIR/tinyurl.sh"
source "$PROJECT_ROOT_DIR/url_to_pdf.sh"
source "$PROJECT_ROOT_DIR/youtube-dl.sh"
source "$PROJECT_ROOT_DIR/stdmatt_com.sh"
source "$PROJECT_ROOT_DIR/wargaming.sh"

## Hacks for each platform...
source "$PROJECT_ROOT_DIR/osx_hacks.sh"
source "$PROJECT_ROOT_DIR/windows_hacks.sh"