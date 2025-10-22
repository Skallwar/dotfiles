{ config, pkgs, ... }:

{
  services.nginx.enable = true;
  # services.postgresql.enable = true;

  services.vikunja = {
    enable = true;
    # setupNginx = true;
    database = {
      type = "postgres";
      host = "/run/postgresql";
    };
    frontendScheme = "http";
    frontendHostname = "localhost";
    settings = {
      service.enableregistration = false;
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "vikunja" ];
    ensureUsers = [{
      name = "vikunja";
      ensureDBOwnership = true;
    }];
    # dataDir = "/data/postgresql/${config.services.postgresql.package.psqlSchema}";
  };

  services.postgresqlBackup = {
    enable = true;
    databases = [ "vikunja" ];
  };

  # environment.systemPackages = with pkgs; [
  #   vikunja-api
  # ];
}
