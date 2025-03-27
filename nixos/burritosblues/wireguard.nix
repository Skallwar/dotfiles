{ config, pkgs, lib, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 30566 51820 ]; # Clients and peers can use the same port, see listenport
    checkReversePath = false;
  };

  sops.secrets = {
    paris_config = {
      sopsFile = ./wireguard_secret.yaml;
      owner = "root";
      path = "/etc/NetworkManager/system-connections/paris.nmconnection";
      restartUnits = ["NetworkManager.service"];
    };
    antibes_config = {
      sopsFile = ./wireguard_secret.yaml;
      owner = "root";
      path = "/etc/NetworkManager/system-connections/antibes.nmconnection";
      restartUnits = ["NetworkManager.service"];
    };
    antibes-lan_config = {
      sopsFile = ./wireguard_secret.yaml;
      owner = "root";
      path = "/etc/NetworkManager/system-connections/antibes-lan.nmconnection";
      restartUnits = ["NetworkManager.service"];
    };
  };
}
