#!/usr/bin/env bash

packages=(
    pip
    pynvim
);

for item in ${packages[@]}; do
    sudo python3 -m pip install --upgrade $item;
done;