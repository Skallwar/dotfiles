#!/usr/bin/env bash

exec i3lock -i $(find ~/dotfiles/img/lock/ -name "*png" | shuf -n1)
