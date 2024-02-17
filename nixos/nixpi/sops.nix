{ config, pkgs, ... }:


{
  config = {
    sops.defaultSopsFile = ./secrets.yaml;
    # sops.secrets.nginx_selfsigned_crt = {};
    # sops.secrets.nginx_selfsigned_key = {};
    sops.secrets."mosquitto/users/zigbee2mqtt/password" = {};
    # sops.secrets.zigbee2mqtt_secret = {
    #   sopsFile = ./zigbee2mqtt_secret.yaml;
    # };
  };
}
