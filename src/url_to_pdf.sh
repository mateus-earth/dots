##~---------------------------------------------------------------------------##
##                        _      _                 _   _                      ##
##                    ___| |_ __| |_ __ ___   __ _| |_| |_                    ##
##                   / __| __/ _` | '_ ` _ \ / _` | __| __|                   ##
##                   \__ \ || (_| | | | | | | (_| | |_| |_                    ##
##                   |___/\__\__,_|_| |_| |_|\__,_|\__|\__|                   ##
##                                                                            ##
##  File      : url_to_pdf.sh                                                 ##
##  Project   : dots                                                          ##
##  Date      : Feb 19, 2019                                                  ##
##  License   : GPLv3                                                         ##
##  Author    : stdmatt <stdmatt@pixelwizards.io>                             ##
##  Copyright : stdmatt - 2019                                                ##
##                                                                            ##
##  Description :                                                             ##
##    Downloads the webpage to a pdf file.                                    ##
##---------------------------------------------------------------------------~##

##---------------------------------------------------------------------------~##
## Functions                                                                  ##
##---------------------------------------------------------------------------~##
##------------------------------------------------------------------------------
url-to-pdf()
{
    local URL="$1";
    local output_path="$(basename "$URL").pdf";

    ##
    ## Log info.
    echo "URL : ${URL}";
    echo "FILE: ${output_path}";
    echo "Downloading...";

    echo "import pdfkit; pdfkit.from_url(\"${URL}\", \"${output_path}\")" | python - > /dev/null
    echo "Done...";
}

##------------------------------------------------------------------------------
open-article()
{
    local owncloud_path="$HOME/owncloud/articles";

    local URL="$1";
    local output_path="$(basename "$URL").pdf";

    if [ ! -e "$owncloud_path/$output_path" ]; then
        url-to-pdf "$URL";
        mv "$output_path" "$owncloud_path/$output_path"
    fi;

    ## XXX(stdmatt): Only works for OSX right now...
    open "$owncloud_path/$output_path";
}