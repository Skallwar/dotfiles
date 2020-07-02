#!/bin/sh

path_origin="$(pwd)"
path_target="$1"

if [ -z "$path_target" ]
then
    echo "Usage: ./install.sh [TARGET_DIRECTORY]"
    exit 1
elif [[ $path_target != /* ]]
then
    path_target=${path_target%/*}
    path_target="$path_origin/$path_target"
fi

echo -n "Install dotfiles? [y/N]: "
read needdot
if [ "$needdot" = "y" -o "$needdot" = "Y" ]
then
echo Installing config files
ln -sfv $path_origin/config/vimrc $path_target/.vimrc
ln -sfv $path_origin/config/zshrc $path_target/.zshrc
ln -sfv $path_origin/config/xinitrc $path_target/.xinitrc
ln -sfv $path_origin/config/makepkg.conf /etc/makepkg.conf
echo
fi

echo -n "Install i3 config? [y/N]: "
read needi3
if [ "$needi3" = "y" -o "$needi3" = "Y" ]
then
    ln -sfv $path_origin/config/i3/i3config $path_target/.config/i3/config
fi

echo -n "Install laptop services? [y/N]: "
read needServices
if [ "$needServices" = "y" -o "$needServices" = "Y" ]
then
    #Lowbat-suspend
    sudo cp -fv $path_origin/services/lowbat-suspend.timer /etc/systemd/system &&
    sudo cp -fv $path_origin/services/lowbat-suspend.service /etc/systemd/system &&
    sudo cp -fv $path_origin/services/lowbat-suspend.sh /etc/systemd/system&&
    sudo systemctl enable lowbat-suspend.timer && 
    sudo systemctl start lowbat-suspend.timer

    #Suspend
    sudo cp -fv $path_origin/services/suspend.service /etc/systemd/system &&
    sudo cp -fv $path_origin/services/suspend.sh /etc/systemd/system &&
    sudo systemctl enable suspend.service
fi

echo -n "Install U2F config? [y/N]: "
read needU2F
if [ "$needU2F" = "y" -o "$needU2F" = "Y" ]
then
    sudo pacman -S pam-u2f
    sudo sed -i '2iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname cue [prompt=Please touch the device]' /etc/pam.d/sudo
    sudo sed -i '3iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname' /etc/pam.d/login
    sudo sed -i '6iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname' /etc/pam.d/i3lock
fi

exit 0
