#!/bin/sh

cp ~/.bashrc .
cp ~/.vimrc .

cp ~/.config/i3/* .config/i3/
cp ~/.config/polybar/* .config/polybar/
cp -r ~/.config/rofi/* .config/rofi/
cp ~/.config/dunst/dunstrc .config/dunst/
cp ~/.config/kitty/kitty.conf .config/kitty/

cp ~/.local/bin/rofi-power-menu bin/
