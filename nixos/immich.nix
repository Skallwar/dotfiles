{ config, pkgs, lib, ... }:

{
  services.immich = {
    enable = true;
    host = "localhost";
    openFirewall = true;
    mediaLocation = "/data/immich"
  };
}
