#!/usr/bin/env bash

packages=(
    npm
    ## Neovim things...
    neovim
    bash-language-server
);

for item in "${packages[@]}"; do
    echo "Installing ($item).";
    npm install -g "$item";
done;

npm update -g;
