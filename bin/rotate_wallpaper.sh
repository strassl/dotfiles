#!/bin/bash

walls_dir=$HOME/pictures/wallpapers
selection=$(find $walls_dir -maxdepth 1 -type f -name "*.jpg" -o -name "*.png" | shuf -n1)
nitrogen --set-auto $selection
ln -sfn $selection $HOME/pictures/wallpaper
