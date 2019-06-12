##~---------------------------------------------------------------------------##
##                        _      _                 _   _                      ##
##                    ___| |_ __| |_ __ ___   __ _| |_| |_                    ##
##                   / __| __/ _` | '_ ` _ \ / _` | __| __|                   ##
##                   \__ \ || (_| | | | | | | (_| | |_| |_                    ##
##                   |___/\__\__,_|_| |_| |_|\__,_|\__|\__|                   ##
##                                                                            ##
##  File      : tinyurl.sh                                                    ##
##  Project   : dots                                                          ##
##  Date      : Apr 22, 2019                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : stdmatt <stdmatt@pixelwizards.io>                             ##
##  Copyright : stdmatt - 2019                                                ##
##                                                                            ##
##  Description :                                                             ##
##    Make the url short using the tinyurl.com.                               ##
##---------------------------------------------------------------------------~##

##------------------------------------------------------------------------------
tinyurl()
{
    local url="$1";
    test -z "$url"                                   && \
        echo "[tinyurl] URL is required - Aborting." && \
        return 1;

    curl tinyurl.com/api-create.php?url="$url";
}
