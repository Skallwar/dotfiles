{ config, pkgs, ... }:

{
  imports = [ ./cli.nix ./flatpak.nix ];

  environment.systemPackages = with pkgs; [
    unstable.alacritty neofetch arandr nemo pavucontrol yaru-theme flameshot xscreensaver
    firefox chromium signal-desktop xournalpp vlc
    gparted android-file-transfer
    networkmanagerapplet
    peazip

    # Office
    libreoffice onlyoffice-desktopeditors
    hunspell hunspellDicts.en_US hunspellDicts.fr-any
  ];

  # In a DE there is a good chance I will try an download a binary at some point...
  programs.nix-ld.enable = true;
}
