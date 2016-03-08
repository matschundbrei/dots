#!/bin/bash
#second screen setup:
xrandr --output eDP1 --primary --auto --right-of HDMI1 --output HDMI1 --auto
#Background image
feh --bg-scale ~/Pictures/some_wp.jpeg

#pointer setup
xsetroot -cursor_name left_ptr

# set German keyboard layout
setxkbmap -layout de

#tray icon stuff
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x191970 --height 12 &

#network applet
nm-applet &

#more power ;)
gnome-power-manager &

#xscreensaver
xscreensaver -no-splash &

#apply gnome settings
#gnome-settings-daemon &

#gnome-keyring ssh helper
#via: http://blog.san-ss.com.ar/2011/03/using-gnome-keyring-in-xmonad.html
#eval $(gnome-keyring-daemon --start)
#export GNOME_KEYRING_CONTROL
#export GNOME_KEYRING_PID
#export SSH_AUTH_SOCK

#dropbox
dropbox start

#truecrypt
truecrypt &

#notes:
xfce4-notes &

#use keyboard and mouse over at windoze
# synergy &

exec xmonad

