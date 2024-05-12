{ config, pkgs, ... }:

{
  # Fwupd
  services.fwupd.enable = false;
  services.udisks2.enable = true; # Error on fwupdmgr update otherwise

  # Enable hostname resolution on local network
  services.avahi.nssmdns = true;

  # Never authorized password ssh login
  services.openssh.settings.PasswordAuthentication = false;

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];
}
