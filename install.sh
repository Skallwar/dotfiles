#!/bin/bash

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

echo Installing config files
ln -sfv $path_origin/config/vimrc $path_target/.vimrc
ln -sfv $path_origin/config/zshrc $path_target/.zshrc
echo

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

exit 0
