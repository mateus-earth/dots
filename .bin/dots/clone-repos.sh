#!/usr/bin/env bash

##
## Constants
##

URL="https://api.github.com/user/repos";
TMP_FILE="/tmp/matt.repos";

PUBLIC_PATH="$HOME/Projects/public";
PRIVATE_PATH="$HOME/Projects/private";


##
## Functions
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

if [ -z "$GITHUB_TOKEN_CLONE_ALL_REPOS" ]; then
    echo "Missing Github Token (GITHUB_TOKEN_CLONE_ALL_REPOS)";
    exit 1;
fi;


echo "Getting repo list from github.com...";
curl                                                                \
     -H "Authorization: token $GITHUB_TOKEN_CLONE_ALL_REPOS" "$URL" \
     -o "$TMP_FILE";

public_repos=$(jq '.[] | select(.owner.login == "mateus-earth") | select(.private == false) | .ssh_url' $TMP_FILE);
private_repos=$(jq '.[] | select(.owner.login == "mateus-earth") | select(.private == true)  | .ssh_url' $TMP_FILE);

echo "Clonning personal repos:";
for url in $public_repos; do
    clone_repo $url $PUBLIC_PATH;
done;

echo "Clonning forked repos:";
for url in $private_repos; do
    clone_repo $url $PRIVATE_PATH;
done;

echo "Done...";