{ config, pkgs, lib, ... }:

{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "system_log"
      "systemmonitor"
      "syncthing"
      "meteo_france"
      "ffmpeg"
      "androidtv"
      "androidtv_remote"
      "freebox"
      "upnp"
      "mqtt"
      "roborock"
      # "google_maps"
      "cast"
    ];
    extraPackages = python3Packages: with python3Packages; [
      gtts
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};

      sensor = [
        {
          platform = "systemmonitor";
          scan_interval = "5";
          resources = [
            { type = "last_boot"; }
            { type = "processor_use"; }
            { type = "processor_temperature"; }
            { type = "memory_use_percent"; }
            { type = "memory_use"; }
            { type = "memory_free"; }
            # { type = "swap_use_percent"; }
            # { type = "swap_use"; }
            # { type = "swap_free"; }
            { type = "ipv4_address"; arg = "end0"; }
            { type = "ipv6_address"; arg = "end0"; }
            { type = "network_in"; arg = "end0"; }
            { type = "network_out"; arg = "end0"; }
            { type = "throughput_network_in"; arg = "end0"; }
            { type = "throughput_network_out"; arg = "end0"; }
            { type = "disk_use_percent"; arg = "/"; }
            { type = "disk_use"; arg = "/"; }
            { type = "disk_free"; arg = "/"; }
            { type = "disk_use_percent"; arg = "/data"; }
            { type = "disk_use"; arg = "/data"; }
            { type = "disk_free"; arg = "/data"; }
          ];
        }
      ];
    };
  };

  # virtualisation.oci-containers = {
  #   backend = "podman";
  #   containers.homeassistant = {
  #     volumes = [ "home-assistant:/config" ];
  #     environment.TZ = "Europe/Paris";
  #     image = "docker.io/library/zigbee2mqtt/zigbee2mqtt-aarch64:1.33.2-1"; # Warning: if the tag does not change, the image will not be updated
  #     extraOptions = [ 
  #       "--network=host" 
  #       # "--device=/dev/ttyACM0:/dev/ttyACM0"  # Example, change this to match your own hardware
  #     ];
  #   };
  # };

  services.mosquitto = {
    enable = true;
    listeners = [{
      users.zigbee2mqtt = {
        acl = [ "readwrite #" ];
        passwordFile = config.sops.secrets."mosquitto/users/zigbee2mqtt/password".path;
      };
    }];
  };

  services.zigbee2mqtt = {
    enable = true;
    settings = {
      homeassistant = config.services.home-assistant.enable;
      serial = {
        port = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
        # disable_led = false;
      };
      mqtt = {
        server = "mqtt://localhost:1883";
        user = "zigbee2mqtt";
        password = "!secret.yaml";
      };
      frontend = {
        port = 8842;
        host = "0.0.0.0";
      };
    };
  };
}
