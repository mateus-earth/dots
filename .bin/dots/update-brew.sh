##
## Packages 
##

core_packages=(
    gcc
    automake
    atool
    curl
    coreutils
    diffutils
    ed
    findutils
    git
    exa
    fd
    gawk
    gnu-sed
    gnu-tar
    grep
    jq
    libtool
    lynx
    make
    peco
    ripgrep
    tree
    vifm
    wget
);

workstation_packages=(
    cmake
    gource
    gtk+3
    librsvg
    ninja
    openssl@3
    pandoc
    rust
    rustup-init
    vagrant
    virtualbox
    yarn
    youtube-dl
    alacritty
    vlc
    telegram
    transmission
)


##
## Functions 
##

function install_profile() 
{
    arr="";
    if [ "$1" == "--core" ]; then 
        arr=${core_packages[@]};
    elif [ "$1" == "--workstation" ]; then 
        arr=${workstation_packages[@]};
    else 
        echo "Invalid flag: $1";
        exit 1;
    fi;

    ## Get the packages that we already have installed...
    local brew_installed_txt="/tmp/brew_installed.txt";
    (brew list --formula -1) >  "$brew_installed_txt";
    (brew list --cask    -1) >> "$brew_installed_txt";
    
    ## Iterate and install missing...
    for item in ${arr[@]}; do 
        if [ -n "$(grep "$item" "$brew_installed_txt")" ]; then 
            echo "Already installed: ($item)";
        else
            echo "Installing: ($item)";
        fi;
    done;
}


##
## Script 
##

## Args
args=$@;
if [ $# -eq 0 ]; then
    echo -e "Usage:\n    update-brew.sh --core --workstation";
    exit 1;
fi;

## Ensure brew...
if [ -z "$(which brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

    if [ "$(uname)" == "Linux" ]; then
        sudo apt-get -y update; 
        sudo apt-get -y upgrade;
        sudo apt-get -y install build-essential procps curl file git;

        test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"; ## Make brew accessible in Linux;
    fi;
fi;

## Install the desired profile.
brew update;
brew upgrade;

for arg in ${args[@]}; do
    install_profile $arg;
done;

brew cleanup;