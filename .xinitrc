#!/bin/sh

xset +fp /usr/share/fonts/local
xset fp rehash
xrandr --output DVI-I-1 --mode 1440x900 --pos 0x0 --output DP-1 --mode 1280x1024 --pos 1440x0
feh --bg-scale ~/backgrounds/grey-fractal-1440-900.jpg ~/backgrounds/grey-fractal-1280-1024.jpg
exec subtle
