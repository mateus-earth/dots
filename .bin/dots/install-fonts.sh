#!/usr/bin/env bash


SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd);
FONTS_DIR="$HOME/.bin/dots/fonts";

IS_GNU=$(test "$(uname)" == "Linux" && echo "gnu");

install_dir="$HOME/.local/share/fonts"; ## GNU
if [ -z "$IS_GNU" ]; then 
  install_dir="$HOME/Library/Fonts"; ## macOS
fi

mkdir -p "$install_dir"; ## Make sure that directory exists...

echo "Copying fonts...";
find $HOME/.bin/dots/fonts -iname "*tf" -print0 | xargs -0 -n1 -I % cp -v "%" "$install_dir";
if [ -n "$IS_GNU" ]; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi;

echo "Fonts installed...";
