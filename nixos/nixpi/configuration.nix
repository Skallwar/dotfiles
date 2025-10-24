# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, modulesPath, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # <nixos-hardware/raspberry-pi/4>
      (modulesPath + "/profiles/minimal.nix")
      (modulesPath + "/profiles/headless.nix")

      ./hardware-configuration.nix
      ./dnsmasq.nix
      ./wireguard_server.nix
      ./syncthing.nix
      ./sops.nix
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # Filesystems
  boot.supportedFilesystems = [ "ntfs" ];
  # Enable ssh recovery
  boot.initrd.network.ssh.enable = true;
  systemd.watchdog.runtimeTime = "60s";

  # PowerManagement
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  # Enable networking
  networking.hostName = "nixpi";
  networking.firewall.enable = false;
  # networking.networkmanager.enable = true;

  # system.activationScripts = {
  #   rfkillUnblockWlan = {
  #     text = ''
  #       rfkill unblock wlan
  #     '';
  #     deps = [];
  #   };
  # };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/DATA";
    fsType = "ext4";
  };

  # Bluetooth
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.utf8";
    LC_IDENTIFICATION = "fr_FR.utf8";
    LC_MEASUREMENT = "fr_FR.utf8";
    LC_MONETARY = "fr_FR.utf8";
    LC_NAME = "fr_FR.utf8";
    LC_NUMERIC = "fr_FR.utf8";
    LC_PAPER = "fr_FR.utf8";
    LC_TELEPHONE = "fr_FR.utf8";
    LC_TIME = "fr_FR.utf8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pi = {
    isNormalUser = true;
    description = "pi";
    hashedPassword = "$y$j9T$WoJd3DErDyhn2wtwlObXM/$n/CgQv67jhvt8kylQ7UgA0Ifpi5qqRUbArEkkMwxj50";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyWXFuqSw+JLEnVp13ea+uWXuUHOaR+/g5pmyiWrDl3lWETxRJpzkUu6cIVERtdQDFRZpwlWFo/sD2K2whHjO1ynzuKEM3OupGAe8tEaxcI6FiqH8rYyNNus1eW9qZ9SQCLYLtCI7Yfk0muilTk0l6qolczkwzNVi9IQCCM6ZIRN1bQFSaxQ7If51nnfTqXkkvkunt2ccibZZ4am1SHpnA5o8DIobRYEyniVpcT+yhmP0UCjxfxH+6UvjgHJDq8bqhir6TojVQprkBFEDNPq+Lr8LY2uM0UpfobqlvoNZy8kXqGT8xcHyVkRHfvPXbUyU1ze8ZphTXV+is0SgS1cNUWP0d5oQHfjJK3YjWkTSo/iztUCMT6FvdHDxvVqXVQ1GX9VcYXXIgeh5cZ5XxAxbgsVNJ+R/pAuHomb8PnPQ+MV+4lXYz0zBGhOhgUDZzJ3HZYwcAOTVTfFnGlIZwEJ6u6oXM/OS9ga+zD6nt6tyfzxyHtJxzueo+7U2OnBRbP3JKnEEkyYoIdqwOyJzdXexqmRS85XsEUxmgmPjPd3ewwiLsU8SVkaVZuzVtRQXl+ndNPnQHEP3Uvo5gN5HHUaFrR9etI5pmGLzoK7EE3DCEKz7Svga1C0ZpiLxCCTBeVHzZsa7lplp+jDP8Xno0zbM6CqqzkaW6+6twZ5CrdsvynQ== openpgp:0x60AC42D3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlz4K7iCvJSht6B7SolU+1J3rAMJ/1pX+OhrAQwVq+N esteban@burritosblues"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNPVIBLk/AOyflGnWK9GsN4mauL93smUd6YqgvvMEIr redmi10"
    ];
    extraGroups = [ "networkmanager" "wheel" "audio" "dialout" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Use nix-ld for non patched binaries
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
     raspberrypi-eeprom
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  # Nix
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''system = aarch64-linux'';
  nix.settings.trusted-users = [ "@wheel" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
