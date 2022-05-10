##-----------------------------------------------------------------------------
function create-ssh-key()
{
    local email="$(git config user.email)";
    local ssh_path="$HOME/.ssh/id_ed25519";
    if [ ! -f "$ssh_path" ]; then 
        echo "Creating ssh-key at: ($ssh_path)"; ## @todo(echo): Move to log...

        cat /dev/zero | ssh-keygen -q -N "" -t ed25519 -C "$email";
        eval "$(ssh-agent -s)";
        ssh-add "$ssh_path";
    fi;
    
    echo "---------------------------------------------"
    cat ~/.ssh/id_ed25519.pub;
    echo "---------------------------------------------"
}

##-----------------------------------------------------------------------------
function connect-to-server()
{
    local server_name=$(cat ~/.ssh/known_hosts | cut -d" " -f1 | sort | uniq | peco);
    test -z "$server_name" && echo "Ok..." && return;

    local conn_str="$server_name";
    local user_name="$1";
    if [ -n "$user_name" ]; then 
        conn_str="$user_name@$server_name";
    fi;

    echo "Connecting to: ($conn_str)";
    ssh $conn_str;
}
