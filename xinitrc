#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# x config

# mute pc speaker
xset -b
# key repeat delay&rate
xset r rate 200 30
# mouse accel, speed
xset m 4 0
xinput --set-prop 12 'libinput Accel Speed' 1.0
# disable touchpad entirely
xinput --disable 11
# disable dpms
xset -dpms
# disable screen blanking
xset s off

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#xterm -geometry 110x55-0+0 -name right &
#exec xterm -geometry 110x55+0+0 -name left
feh --bg-max --randomize ~/.wallpapers/milky.jpg &
compton -c -D 1 -o 0.9 --sw-opti &
exec xmonad
