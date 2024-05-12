{config, pkgs, ...}:

{
  services.syncthing = {
    enable = true;
    user = "esteban";
    group = "users";
    dataDir = "/home/esteban/";
    configDir = "/home/esteban/.config/syncthing";
    guiAddress = "localhost:8384";

    settings = {
      devices = {
        "Nixpi" = { 
          id = "YYEDLNB-QCQKAGT-WTNCK4R-VXPMJB7-OAATXYT-UPJ74FJ-JXH4PCD-NLCDEQO";
          introducer = true;
        };
      };
      
      folders = {
        "Admin" = {
          path = "/home/esteban/Esteban";
          devices = ["Nixpi"];
        };
      };
    };
  };
}
