{ config, pkgs, ... }:

{
  # Make sure our IP is static
  networking = {
    useDHCP = false;
    interfaces.end0 = {
      ipv4.addresses = [{
        address = "192.168.1.251";
        prefixLength = 24;
      }];
    };
    defaultGateway = {
      address = "192.168.1.254";
      interface = "end0";
    };
    nameservers = [ "192.168.1.251" ];
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      # upstream DNS servers
      server = [ "194.242.2.3" ];
      # sensible behaviours
      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;

      # Cache dns queries.
      cache-size = 1000;

      # Range is excluding Bbox IP
      dhcp-range = [ "192.168.1.1,192.168.1.253,24h" ];
      interface = "end0";
      dhcp-host = "192.168.1.1";
      # Give the gateway address
      dhcp-option="option:router,192.168.1.254";
      dhcp-authoritative=true;

      # local domains
      local = "/lan/";
      domain = "lan";
      expand-hosts = true;

      # don't use /etc/hosts as this would advertise surfer as localhost
      no-hosts = true;
      address = "/*.skallwar.fr/192.168.1.251";
    };
  };

}
