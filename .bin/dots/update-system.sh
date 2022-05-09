
echo "This will probably shutdown the computer...";

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1;
fi

## Mac
if [ "$(uname)" == "Darwin" ]; then
    # sudo softwareupdate -i -a;    
    echo ""
else 
    echo  "To implement.."
fi;

## Brew
${HOME}/.bin/dots/update-brew.sh --core --workstation 

## NPM
sudo npm install npm -g;
sudo npm update      -g;
