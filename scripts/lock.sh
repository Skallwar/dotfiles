#!/usr/bin/env bash

exec i3lock -i $(find ~/.wallpaper/lock/ -name "*png" | shuf -n1)
