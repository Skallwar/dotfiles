{config, pkgs, ...}:

{
  services.syncthing = {
    enable = true;
    user = "syncthing";
    dataDir = "/data/syncthing";    # Default folder for new synced folders
    configDir = "/data/.config/syncthing";   # Folder for Syncthing's settings and keys
    # openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    
    devices = {
      "redmi" = { id = "BQ4RQPP-B7GVSPM-QUKRF55-PFWWLMV-FYFA7BF-RIQOESL-GL5ULRA-S3BPRA4"; };
      "burritosblues" = { id = "FT4XMTE-CMU4LN2-WVFJCML-Q2PLCMP-YYRRJDJ-2QZR53M-JYD34SL-I55DLA7"; };
      "PCMASTERACE" = { id = "XNISIE3-PXBKVLA-TSD47VH-FNHIOFN-XYRDRZJ-B7ST2EC-NAVQ4CT-D6YINAT"; };
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
    };
  };
  
 # networking.firewall.allowedTCPPorts = [ 8384 22000];
 # networking.firewall.allowedUDPPorts = [ 22000 21027];
}