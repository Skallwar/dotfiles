{ config, pkgs, ... }:

{
  services.nginx.enable = true;
  # services.postgresql.enable = true;

  services.vikunja = {
    enable = true;
    setupNginx = true;
    # database.type = "postgres";
    frontendScheme = "http";
    frontendHostname = "localhost";
    settings = {
      service.enableregistration = false;
    };
  };

  environment.systemPackages = with pkgs; [
    vikunja-api
  ];
}
