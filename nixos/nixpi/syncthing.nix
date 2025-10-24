{config, pkgs, ...}:

{
  services.syncthing = {
    enable = true;
    user = "syncthing";
    dataDir = "/data/syncthing";    # Default folder for new synced folders
    configDir = "/data/.config/syncthing";   # Folder for Syncthing's settings and keys
    # openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";

    settings = {
      devices = {
        "redmi" = { id = "BQ4RQPP-B7GVSPM-QUKRF55-PFWWLMV-FYFA7BF-RIQOESL-GL5ULRA-S3BPRA4"; };
        "burritosblues" = { id = "FT4XMTE-CMU4LN2-WVFJCML-Q2PLCMP-YYRRJDJ-2QZR53M-JYD34SL-I55DLA7"; };
        "PCMASTERACE" = { id = "XNISIE3-PXBKVLA-TSD47VH-FNHIOFN-XYRDRZJ-B7ST2EC-NAVQ4CT-D6YINAT"; };
        "Macha-PC" = { id = "KEH534Q-26GUJVO-5IUPCM3-WV6R33K-BS6UQ7M-S4DZPRJ-TUKIRKX-CR24FQO"; };
      };

      folders = {
        "Camera" = {
          id = "m2007j17g_rr4b-photos";
          path = "/data/syncthing/Photos";
          devices = [ "redmi" "burritosblues" "PCMASTERACE" ];
        };
        "Admin" = {
          path = "/data/syncthing/Admin";
          devices = [ "redmi" "burritosblues" "PCMASTERACE" ];
        };
        "Playnite" = {
          path = "/data/syncthing/Playnite";
          devices = [ "PCMASTERACE" "Macha-PC" ];
        };
        "PhoneBackups" = {
          id = "sig36-5ap6f";
          path = "/data/syncthing/PhoneBackups";
          devices = [ "redmi" "PCMASTERACE" "burritosblues" ];
        };
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    virtualHosts."syncthing.skallwar.fr" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8384";
        proxyWebsockets = true;
      };
    };
  };

 # networking.firewall.allowedTCPPorts = [ 8384 22000];
 # networking.firewall.allowedUDPPorts = [ 22000 21027];
}
