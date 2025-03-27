{ config, pkgs, ... }:

{
  sops.defaultSopsFile = ./secrets.yaml;
  # sops.secrets.nginx_selfsigned_crt = {};
  # sops.secrets.nginx_selfsigned_key = {};
  sops.secrets."mosquitto/users/zigbee2mqtt/password" = {};
  sops.secrets."mosquitto/users/zigbee2mqtt/secret.yaml" = {
    owner = "zigbee2mqtt";
    path = "/data/zigbee2mqtt/data" + "/secret.yaml";
  };
  sops.secrets."wireguard/server/privatekey" = {};
}
