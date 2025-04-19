#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For manually starting xdg-desktop-portal-hyprland

killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal-gnome
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal-hyprland &
/usr/libexec/xdg-desktop-portal-hyprland &
/usr/lib/xdg-desktop-portal &
/usr/libexec/xdg-desktop-portal &

