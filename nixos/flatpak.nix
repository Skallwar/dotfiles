{ config, pkgs, ...}:

{
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  xdg.portal.configPackages = with pkgs; [ gnome-session ];
  programs.dconf.enable = true;
}
