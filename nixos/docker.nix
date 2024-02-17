{ config, pkgs, lib, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    # ipv6 = true;
    dns = ["8.8.8.8"];
  };

  users.users.esteban.extraGroups = [ "docker" ];
}
