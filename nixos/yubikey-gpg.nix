{ config, lib, pkgs, ... }:

{
  programs.ssh.startAgent = false;

  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };  

  environment.systemPackages = with pkgs; [
    gnupg
    yubikey-manager
  ];

  services.udev.packages = with pkgs; [
    yubikey-manager
  ];
  
  environment.shellInit = ''
    # export GPG_TTY="$(tty)"
    # gpg-connect-agent /bye
    # export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';
}
