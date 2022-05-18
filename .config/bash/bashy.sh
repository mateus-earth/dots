export bashy_Platform=$(uname);
export bashy_IsGNU=$(test $bashy_Platform == "Linux" && echo "1");
export bashy_IsMacOS=$(test $bashy_Platform == "Darwin" && echo "1");


function bashy_get_arg()
{
    local flag="$1"; shift;

    for i in $(seq 1 $#); do
        if [ "$1" == "$flag" ]; then
            shift;
            echo $1;
            return;
        fi;

        shift;
    done;
}


## https://stackoverflow.com/a/17841619
function bashy_join_by()
{
    local d=${1-} f=${2-}
    if shift 2; then
        printf %s "$f" "${@/#/$d}"
    fi
}
