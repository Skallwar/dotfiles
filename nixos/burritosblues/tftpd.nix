{config, pkgs, ...}:

{
  services.nfs.server = {
    enable = false;
    exports = ''
      /srv/nfs/ *(insecure,rw,sync,no_subtree_check,no_root_squash,nohide)
    '';
  };

  services.dnsmasq = {
    enable = false;
    resolveLocalQueries=false;
    settings = {
      # Tftp
      enable-tftp = true;
      tftp-root = "/srv/tftp";
    };
  };

  # Act as a routeur, forwarding trafic from the subnet to our own gateway
  # boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}
