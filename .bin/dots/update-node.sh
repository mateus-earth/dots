#!/usr/bin/env bash

packages=(
    npm
    neovim
);

for item in ${packages[@]}; do
    npm install -g $item;
done;

npm update -g;