{ config, pkgs, ... }:

{
  services.fail2ban = {
    enable = true;
    ignoreIP = [ 
      "192.168.27.0/24" # Wireguard subnet
    ];

    jails.sshd.settings = {
      enabled = true;
      mode = "aggressive";
    };
  };
}
