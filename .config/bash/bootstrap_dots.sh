#!/usr/bin/env bash

DOTS_PATH="$HOME/Projects/public/dots";

function _git() {
    git --git-dir="$DOTS_PATH" --work-tree=$HOME "$@";
}

if [ "$(uname)" == "Linux" ]; then
    has_git="$(which git)"
    if [ -z "$has_git" ]; then
        echo "Installing requirements for GNU";
        sudo apt-get update  -y;
        sudo apt-get upgrade -y;
        sudo apt-get install git;
    fi;
fi;

echo "Clonning dots...";
mkdir -p "$DOTS_PATH";
git clone --bare https://github.com/mateus-earth/dots.git "$DOTS_PATH";

echo "Syncing up...";
_git checkout --force;

echo "Changing url to ssh...";
_git remote set-url origin git@github.com:mateus-earth/dots.git;
_git config --get remote.origin.url

echo "Remember to add a ssh key to github...";
