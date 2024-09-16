#!/usr/bin/env bash

# SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | cut -d' ' -f7)"
# BGCOLOR="0,0,0"
# IMG="$(find ~/dotfiles/wallpaper/lock/ -name \"*png\" | shuf -n1)"

# exec convert $IMG -gravity Center -background $BGCOLOR -extent "$SCREEN_RESOLUTION" RGB:- | i3lock

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#ff00ffcc'
TEXT='#ee00eeee'
WRONG='#880000bb'
VERIFYING='#bb00bbbb'

i3lock-color \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$WRONG         \
--bshl-color=$WRONG          \
\
--blur 5                     \
--clock                      \
--indicator                  \
--time-str="%H:%M:%S"        \
--date-str="%A, %d/%m/%Y"       \
# --keylayout 1                \