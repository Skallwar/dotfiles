# Keyboard
setxkbmap us -option caps:escape

# HDMI duplicate
# xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output HDMI1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal
xrandr --setprovideroutputsource modestting NVIDIA-0
xrandr --auto
xrandr --dpi 96

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Ssh
eval $(ssh-agent)

# NetworkManager
nm-applet &

# Blueman
blueman-applet &

# Redshift
redshift -l 48.84:2.35 -t 6500:3500 &

# Dm
exec i3
