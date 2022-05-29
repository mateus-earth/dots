
function _gen_ps1() 
{
    cwd="$(pwd)";
    cwd_len=${#cwd};

    user_info="${USER}@${HOSTNAME}";
    user_info_len=${#user_info};

    date_time="$(date +"%H:%M - %Y-%m-%d")";
    date_time_len=${#date_time};

    left_side_len=$(( cwd_len + 2 ));
    right_side_len=$(( user_info_len + 2 + date_time_len + 2));
    total_len=$(( left_side_len + right_side_len ));

    spaces_len=$(( COLUMNS - total_len - 3 ));
    spaces="";
    for i in $(seq 1 $spaces_len); do 
        spaces="${spaces} ";
    done;

    # PS1="(${cwd}) ($user_info}) ${spaces_len} (${date_time})\n:)";
    PS1="(${cwd}) ${spaces} (${user_info}) (${date_time})\n:)";
}


PROMPT_COMMAND=_gen_ps1;

