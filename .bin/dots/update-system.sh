#!/usr/bin/env bash

echo "This will probably shutdown the computer...";

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1;
fi

## Mac
if [ "$(uname)" == "Darwin" ]; then
    sudo softwareupdate -i -a;    
elif [ "$(uname)" == "Linux" ]; then
    sudo apt-get -y update;
    sudo apt-get -y upgrade;
    sudo apt-get -y dist-upgrade;
fi;

## Brew
${HOME}/.bin/dots/update-brew.sh --core --workstation 

## NPM
npm install npm -g;
npm update      -g;
