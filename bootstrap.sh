#!/bin/sh

for file in ~/.dotfiles/*
do
    if [ ! -f "~/.$file" ]; then
        echo " ln -s  $file ~/.`basename $file`"
        ln -s "$file" "$HOME/.`basename $file`"
    fi
done
