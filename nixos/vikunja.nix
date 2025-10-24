{ config, pkgs, ... }:

{
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

  security.acme.defaults.email = "estblcsk+acme@gmail.com";
  security.acme.acceptTerms = true;

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    virtualHosts."vikunja.skallwar.fr" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:3456";
        proxyWebsockets = true;
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "vikunja" ];
    ensureUsers = [{
      name = "vikunja";
      ensureDBOwnership = true;
    }];
  };

  services.postgresqlBackup = {
    enable = true;
    databases = [ "vikunja" ];
  };
}
