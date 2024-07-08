#!/usr/bin/env bash

#init wallpaper daemon

  swww init &

  #systemctl --user import-environment PATH &
  #systemctl --user restart xdg-desktop-portal.service &

# set wallpaper
# wait a tiny bit for wallpaper
  sleep 2
  sww img ~/Wallpapers/wallpaper.jpg

# network applet
#  nm-applet --indicator &

# waybar
  waybar & 

# dunst
  dunst

#gtk link
 ln -s ~/.config/gtk-4.0/gtk.css ~/.config/gtk-3.0/gtk.css
