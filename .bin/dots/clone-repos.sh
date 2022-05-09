#!/usr/bin/env bash

##
## Constants
##

URL="https://api.github.com/user/repos";
TMP_FILE="/tmp/matt.repos";

OWN_PATH="$HOME/Projects/public";
FORK_PATH="$HOME/Projects/forks";


##
## Funcitons 
##

function clone_repo()
{
    local url="$(echo $1 | sed s/\"//g)";
    local prefix_path="$2";
    
    local name=$(basename "$url" | sed s/\.git//g);
    local target_path="$prefix_path/$name";
    
    test -d $target_path && echo "Already clonned: ($name)" && return;
    
    echo "Clonning repo: ($name) at ($target_path)";
    git clone $url $target_path;
}

## 
## Script
## 

echo "Getting repo list from github.com...";
curl                                                                \
     -H "Authorization: token $GITHUB_TOKEN_CLONE_ALL_REPOS" "$URL" \
     -o "$TMP_FILE";

own_repos=$(jq '.[] | select(.owner.login == "mateus-earth") | select(.fork == false) | .ssh_url' $TMP_FILE);
fork_repos=$(jq '.[] | select(.owner.login == "mateus-earth") | select(.fork == true)  | .ssh_url' $TMP_FILE);

echo "Clonning personal repos:";
for url in $own_repos; do 
    clone_repo $url $OWN_PATH;
done;

echo "Clonning forked repos:";
for url in $fork_repos; do 
    clone_repo $url $FORK_PATH;
done;

echo "Done...";