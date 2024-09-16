{ config, pkgs, ... }:

{
  # Fwupd
  services.fwupd.enable = true;
  services.udisks2.enable = true; # Error on fwupdmgr update otherwise

  # Enable hostname resolution on local network
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Never authorized password ssh login
  services.openssh.settings.PasswordAuthentication = false;

  # No need for root password if connected via ssh
  security.pam.sshAgentAuth.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "esteban" "pi" ];
}
