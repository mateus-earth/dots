##~---------------------------------------------------------------------------##
##                        _      _                 _   _                      ##
##                    ___| |_ __| |_ __ ___   __ _| |_| |_                    ##
##                   / __| __/ _` | '_ ` _ \ / _` | __| __|                   ##
##                   \__ \ || (_| | | | | | | (_| | |_| |_                    ##
##                   |___/\__\__,_|_| |_| |_|\__,_|\__|\__|                   ##
##                                                                            ##
##  File      : youtube.sh                                                    ##
##  Project   : dots                                                          ##
##  Date      : Oct 22, 2018                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : stdmatt <stdmatt@pixelwizards.io>                             ##
##  Copyright : stdmatt - 2018                                                ##
##                                                                            ##
##  Description :                                                             ##
##    Stuff to make the youtube-dl easier to use.                             ##
##---------------------------------------------------------------------------~##

##------------------------------------------------------------------------------
youtube-dl-mp3()
{
    local URL="$1";
    test -z "$URL"                        \
        && echo "Empty url - Aborting..." \
        return 1;

    youtube-dl --extract-audio --audio-format mp3 "$URL";
}
