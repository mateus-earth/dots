function create-ssh-key()
{
    local email="$(git config user.email)";        
    cat /dev/zero | ssh-keygen -q -N "" -t ed25519 -C "$email";
    
    eval "$(ssh-agent -s)";
    ssh-add ~/.ssh/id_ed25519

    echo "---------------------------------------------"
    cat ~/.ssh/id_ed25519.pub;
    echo "---------------------------------------------"
}