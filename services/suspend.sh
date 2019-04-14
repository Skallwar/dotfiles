#!/usr/bin/env bash

exec i3lock -i $(find ~/dotfiles/IMG/LOCK/ -name "*png" | shuf -n1)
