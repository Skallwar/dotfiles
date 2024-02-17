{ config, pkgs, ... }:

{
  imports = [ ./cli.nix ./flatpak.nix ];

  environment.systemPackages = with pkgs; [
    alacritty neofetch arandr cinnamon.nemo pavucontrol yaru-theme flameshot xscreensaver
    firefox chromium signal-desktop xournalpp vlc
    gparted android-file-transfer
    networkmanagerapplet
    peazip

    # Office
    libreoffice onlyoffice-bin
    hunspell hunspellDicts.en_US hunspellDicts.fr-any
  ];
}
