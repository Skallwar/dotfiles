{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLI
    alacritty neovim helix neofetch htop killall tree man-pages ncdu
    nix-output-monitor
    amdctl

    # GUI
    arandr cinnamon.nemo pavucontrol yaru-theme flameshot xscreensaver
    firefox chromium  onlyoffice-bin signal-desktop xournalpp
    gparted
  ];
}
