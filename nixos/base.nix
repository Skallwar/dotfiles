{ config, pkgs, ... }:

{
  # Fwupd
  services.fwupd.enable = true;
  services.udisks2.enable = true; # Error on fwupdmgr update otherwise
}