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
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      # upstream DNS servers
      server = [ "9.9.9.9" "149.112.112.112" ];
      # sensible behaviours
      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;

      # Cache dns queries.
      cache-size = 1000;

      # Range is excluding Bbox IP
      dhcp-range = [ "192.168.1.1,192.168.1.253,24h" ];
      interface = "end0";
      dhcp-host = [
        "192.168.1.1"
        "c8:63:14:72:73:d6,192.168.1.250"
        "dc:a6:32:25:ab:b8,192.168.1.251"
      ];
      # Give the gateway address
      dhcp-option="option:router,192.168.1.254";
      dhcp-authoritative=false; # BBox one still active even when disable, sending NAK

      # local domains
      local = "/lan/";
      domain = "lan";
      expand-hosts = true;

      # don't use /etc/hosts as this would advertise surfer as localhost
      no-hosts = true;
      address = [
        "/*.skallwar.fr/192.168.1.251"
        "/bbox/192.168.1.254"
      ];
    };
  };

  networking.firewall.allowedUDPPorts = [
    67 # DHCP
  ];

}
