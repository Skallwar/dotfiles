{ config, pkgs, lib, ... }:

{
  virtualisation.docker.enable = true;

  users.users.esteban.extraGroups = [ "docker" ];
}
