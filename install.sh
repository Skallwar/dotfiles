#!/bin/sh

arch=$(cat /etc/os-release | grep "^ID" | cut -d "=" -f2)

echo Welcome $USER@$HOSTNAME on $arch !

echo "Install dependencies"
yay -S jq

echo -n "Install apps? [y/N]: "
read needApps
if [ "$needApps" = "y" -o "$needApps" = "Y" ]; then
    yay -S vim alacritty i3 bitwarden-cli
    echo "Please login to bitwarden"
    bw login --raw > ~/.config/Bitwarden\ CLI/session.txt
fi

echo -n "Install dotfiles? [y/N]: "
read needdot
if [ "$needdot" = "y" -o "$needdot" = "Y" ]; then
    # WARNING: No '/' at the end of folders
    configs=( ".vimrc" ".bashrc" ".xinitrc" ".wallpaper" ".config/i3" ".config/i3status" ".makepkg.conf" ".config/alacritty" ".config/spotifyd" ".config/systemd" )

    for config in ${configs[@]}; do
        ln -sTi "$PWD/$config" "$HOME/$config"
    done
fi

echo -n "Import ssh private key? [y/N]: "
read needssh
if [ "$needssh" = "y" -o "$needssh" = "Y" ]; then
    echo "Import ssh key name?: "
    read key
    bw --session $(cat ~/.config/Bitwarden\ CLI/session.txt) get item $key | jq -r '.notes' > ~/.ssh/id_rsa
fi

echo -n "Install laptop services? [y/N]: "
read needLaptopServices
if [ "$needLaptopServices" = "y" -o "$needLaptopServices" = "Y" ]; then
    #Lowbat-suspend
    for file in $(ls services); do
        sudo ln -sTi /home/$USER/.dotfiles/services/$file /etc/systemd/system/$file
    done

    sudo systemctl enable lowbat-suspend.timer &&
    sudo systemctl start lowbat-suspend.timer

    #Suspend
    sudo systemctl enable i3lock.service
fi

echo -n "Install U2F config? [y/N]: "
read needU2F
if [ "$needU2F" = "y" -o "$needU2F" = "Y" ]; then
    yay -S pam-u2f
    sudo sed -i '2iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname cue [prompt=Please touch the device]' /etc/pam.d/sudo
    sudo sed -i '3iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname' /etc/pam.d/login
    sudo sed -i '6iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname' /etc/pam.d/i3lock
fi

echo -n "Install spotifyd ? [y/N]: "
read needSpotifyd
if [ "$needSpotifyd" = "y" -o "$needSpotifyd" = "Y" ]; then
    yay -S spotifyd spotify-tui

    systemctl --user enable spotifyd.service &&
    systemctl --user start spotifyd.service
fi

exit 0
