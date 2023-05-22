# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.extraEntries = {
    "windows.conf" = ''
      title Windows 10
      efi /efi/Microsoft/Boot/bootmgfw.efi
    '';
  };
  boot.loader.systemd-boot.consoleMode = "max";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  
  # Mount disks
  fileSystems = {
    "/game-ssd" = {
      device = "/dev/disk/by-uuid/1376F8B75D4ED355";
      fsType = "ntfs";
      options = [ "uid=1000" "gid=100" "rw" "user" "exec" "umask=000" ];
    };
  };
  
  # services.thermald.enable = true;
  # hardware.fancontrol = {
  #   enable = true;
  #   config = ''
  #     INTERVAL=10
  #   '';
  # };

   # Polkit
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wants = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "gusto"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver = {
    enable = true;
    
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    
    
    libinput = {
      enable = true;

      mouse = {
        accelProfile = "flat";
      };
    };

    desktopManager = {
      xterm.enable = false;
      gnome.extraGSettingsOverrides = ''
      	[org.gnome.desktop.interface]
      	gtk-theme='Yaru'
      '';
    };

    # displayManager.lightdm = {
    #   enable = true;
    #   greeters.slick = {
    #     enable = true;
    #     theme.name = "Yaru";
    #   };
    # };

    # windowManager.i3 = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #     dmenu
    #     i3status-rust
    #     i3lock-color
    #     dunst
    #   ];
    # };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.esteban = {
    isNormalUser = true;
    description = "Esteban";
    extraGroups = [ "networkmanager" "wheel" "audio" "sound" "dialout" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
