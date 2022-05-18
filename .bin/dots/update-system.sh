#!/usr/bin/env bash

echo "This will probably shutdown the computer...";

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1;
fi

## macOS
if [ "$(uname)" == "Darwin" ]; then
    sudo softwareupdate -i -a;
    if [ -z "$(xcode-select -p)" ]; then
        xcode-select --install;
    fi;
## GNU.
elif [ "$(uname)" == "Linux" ]; then
    sudo apt-get -y update;
    sudo apt-get -y upgrade;
    sudo apt-get -y dist-upgrade;
fi;

##
${HOME}/.bin/dots/update-brew.sh --core $FLAG_WORKSTATION;
${HOME}/.bin/dots/update-pip.sh  --core $FLAG_WORKSTATION;
${HOME}/.bin/dots/update-ruby.sh --core $FLAG_WORKSTATION;
${HOME}/.bin/dots/update-node.sh --core $FLAG_WORKSTATION;
