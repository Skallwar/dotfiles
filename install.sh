#!/bin/env bash

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
NC="\033[0;39m"

os=$(cat /etc/os-release | grep "^ID" | cut -d "=" -f2)

function os_specific() {
    case $os in
        arch)
            yay -S i3 alacritty pam-u2f
            ;;
    esac
}

function home_config() {
    # WARNING: No '/' at the end of folders
    configs=( "vimrc" "bashrc" "xinitrc" "wallpaper" "config/i3" "config/i3status" "makepkg.conf" "config/alacritty" "config/spotifyd" "config/systemd" "config/nvim" )

    for config in ${configs[@]}; do
        if [[ $config == config/* ]]; then
            config=${string#"config/"}
            ln -sTi "$PWD/$config" "$HOME/.config/$config"
        else
            ln -sTi "$PWD/$config" "$HOME/.$config"
        fi
    done
}

function is_laptop() {
    if [ -d "/sys/class/power_supply" ]; then
        return 0
    fi

    return 1
}

function services() {
    if [[ `/sbin/init --version` =~ upstart ]]; then
        init=upstart
    elif [[ `systemctl` =~ -\.mount ]]; then 
        init=systemd
        service_dest=/etc/systemd/system
    elif [[ -f /etc/init.d/cron && ! -h /etc/init.d/cron ]]; then
        init=sysv-init
    else
        echo "[${YELLOW}Warning${NC}] Unable to detect init system, skipping."
        return 1
    fi

    for file in $(ls services/$init); do
        sudo ln -sTi "$PWD/services/$init/$file" "$service_dest/$file"
    done

    if is_laptop; then
        sudo systemctl enable lowbat-suspend.timer &&
        sudo systemctl start lowbat-suspend.timer

        #Suspend
        sudo systemctl enable i3lock.service
    fi
}

function u2f_config() {
    sudo sed -i '2iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname cue [prompt=Please touch the device]' /etc/pam.d/sudo
    sudo sed -i '3iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname' /etc/pam.d/login
    sudo sed -i '6iauth		sufficient	pam_u2f.so origin=pam://hostname appid=pam://hostname' /etc/pam.d/i3lock
}

echo -e "Welcome $USER@$HOSTNAME on $os!\n"

echo -e "\n${GREEN}Installing packages and OS specific configurations${NC}"
os_specific

echo -e "\n${GREEN}Installing home configurations files${NC}"
home_config

echo -e "\n${GREEN}Installing services${NC}"
services

echo -e "\n${GREEN}Installing PAM rules for u2f${NC}"
u2f_config


