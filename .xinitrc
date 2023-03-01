#!/bin/sh

SHLVL=0
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
picom -b
unclutter -idle 1 &
exec dwm
