{ config, pkgs, lib, ... }:

{
  # enable NAT
  networking = {
    nat = {
      enable = true;
      externalInterface = "end0";
      internalInterfaces = [ "wg0" ];
    };

    firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 51820 ];
    };

    wireguard = {
      enable = true;
      interfaces = {
        # "wg0" is the network interface name. You can name the interface arbitrarily.
        wg0 = {
          # Determines the IP address and subnet of the server's end of the tunnel interface.
          ips = [ "192.168.27.1/24" ];

          # The port that WireGuard listens to. Must be accessible by the client.
          listenPort = 51820;

          # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
          # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
          postSetup = ''
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 192.168.27.0/24 -o end0 -j MASQUERADE
            ${pkgs.iproute2}/bin/ip link set dev wg0 multicast on
          '';

          # This undoes the above command
          postShutdown = ''
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 192.168.27.0/24 -o end0 -j MASQUERADE
          '';

          # Path to the private key file.
          #
          # Note: The private key can also be included inline via the privateKey option,
          # but this makes the private key world-readable; thus, using privateKeyFile is
          # recommended.
          privateKeyFile = config.sops.secrets."wireguard/server/privatekey".path;

          peers = [
            # List of allowed peers.
            {
              # Burritosblues
              # Public key of the peer (not a file path).
              publicKey = "8ttBKJ8oUe9hf8+sXHzDKmh3vf5Vx2GccDX+CvRoU2U=";
              # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
              allowedIPs = [ "192.168.27.2/32" "224.0.0.251/32" ];
            }
            {
              # Redmi Note 10 T
              publicKey = "MK8S6a0BpWsAY/8SZzLW1sikluJyMNVJcCj+PP9I4EY=";
              allowedIPs = [ "192.168.27.3/32" "224.0.0.251/32" ];
            }
          ];
        };
      };
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    allowPointToPoint = true;
    reflector = true;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
      hinfo = true;
      workstation = true;
    };
  };
}
