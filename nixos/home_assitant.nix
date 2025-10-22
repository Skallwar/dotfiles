{ config, pkgs, lib, ... }:

{
  services.home-assistant = {
    enable = true;
    config.recorder.db_url = "postgresql://@/hass";
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
      "backup"
    ];
    customComponents = [
      (  pkgs.buildHomeAssistantComponent rec {
          owner = "hekmon";
          domain = "rtetempo";
          version = "v1.3.2";

          src = pkgs.fetchFromGitHub {
            inherit owner;
            repo = "rtetempo";
            rev = version;
            hash = "sha256-MLZeX6WNUSgVEv8zapAkkBKY5R1l5ykCcWTleYF0H5o=";
          };

          propagatedBuildInputs = [ pkgs.python313Packages.requests-oauthlib ];

          meta = with lib; {
            description = "RTE Tempo";
            homepage = "https://github.com/hekmon/rtetempo";
            changelog = "https://github.com/hekmon/rtetempo/releases/tag/${version}";
            maintainers = with maintainers; [ k900 ];
            license = licenses.mit;
          };
      })
    ];
    customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
      mushroom
      universal-remote-card
    ];
    extraPackages = python3Packages: with python3Packages; [
      gtts
      psycopg2
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
    configDir = "/data/hass";
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
    dataDir = "/data/zigbee2mqtt/data";
    settings = {
      homeassistant = config.services.home-assistant.enable;
      serial = {
        port = "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0";
        # disable_led = false;
      };
      mqtt = {
        server = "mqtt://localhost:1883";
        user = "zigbee2mqtt";
        password = "!secret.yaml password";
      };
      frontend = {
        port = 8842;
        host = "0.0.0.0";
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "hass" ];
    ensureUsers = [{
      name = "hass";
      ensureDBOwnership = true;
    }];
  };

  services.postgresqlBackup = {
    enable = true;
    location = "/data/postgresql/backup";
    compression = "zstd";
    compressionLevel = 19;
    databases = [ "hass" ];
  };
}
