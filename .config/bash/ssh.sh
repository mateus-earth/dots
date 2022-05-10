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